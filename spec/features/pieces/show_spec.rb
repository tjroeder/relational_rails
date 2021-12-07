require 'rails_helper'

RSpec.describe PiecesController, type: :feature do
  before :each do
    @gallery_1 = Gallery.create!(name: "Art 4 Us", non_profit: true, entry_cost: 4.75)
    @gallery_2 = Gallery.create!(name: "Benji's Gallery", non_profit: false, entry_cost: 10)
    # @piece_1 = Piece.create!(name: "Starry Night", artist: "Vincent Van Gogh", year: 1889, original: false, gallery_id: @gallery_1.id)
    @piece_1 = Piece.create!(name: "Starry Night", artist: "Vincent Van Gogh", year: 1889, original: true, gallery_id: @gallery_1.id)
    @piece_2 = Piece.create!(name: "Self Portrait", artist: "Vincent Van Gogh", year: 1889, original: true, gallery_id: @gallery_1.id)
    @piece_3 = Piece.create!(name: "Girl with the Pearl Earring", artist: "Johannes Vermeer", year: 1665, original: true, gallery_id: @gallery_2.id)

    visit "/pieces"
  end

  describe '#show for piece_1' do
    before :each do
      click_link "Starry Night"
    end

    it 'takes us to the piece path' do
      expect(page).to have_current_path("/pieces/#{@piece_1.id}")
    end

    it 'displays each child with its attributes' do
      expect(page).to have_content(@piece_1.name)
      expect(page).to have_content(@piece_1.artist)
      expect(page).to have_content("Original")
      expect(page).to have_content(@piece_1.year)
    end
  end

  describe '#show for piece_2' do
    before :each do
      click_link "Self Portrait"
    end

    it 'takes us to the piece path' do
      expect(page).to have_current_path("/pieces/#{@piece_2.id}")
    end

    it 'displays each child with its attributes' do
      expect(page).to have_content(@piece_2.name)
      expect(page).to have_content(@piece_2.artist)
      expect(page).to have_content("Original")
      expect(page).to have_content(@piece_2.year)
    end
  end

  describe '#show for piece_2' do
    before :each do
      click_link "Girl with the Pearl Earring"
    end

    it 'takes us to the piece path' do
      expect(page).to have_current_path("/pieces/#{@piece_3.id}")
    end

    it 'displays each child with its attributes' do
      expect(page).to have_content(@piece_3.name)
      expect(page).to have_content(@piece_3.artist)
      expect(page).to have_content("Original")
      expect(page).to have_content(@piece_3.year)
    end
  end

  describe 'nav element at page top' do
    it 'has a nav element with links' do
      expect(page).to have_link("Art Pieces", :href=>"/pieces")
      expect(page).to have_link("Galleries", :href=>"/galleries")
    end

    it 'has link to art pieces index' do
      click_link "Art Pieces"

      expect(page).to have_current_path('/pieces')
    end

    it 'has link to galleries index' do
      click_link "Galleries"

      expect(page).to have_current_path('/galleries')
    end
  end

  describe 'update gallery info link' do
    before :each do
      click_link "#{@piece_1.name}"
    end

    it 'is at a pieces show page' do
      expect(page).to have_current_path("/pieces/#{@piece_1.id}")
    end

    it 'has link to update art piece info page' do
      expect(page).to have_link("Update Art Piece Information", :href=>"/pieces/#{@piece_1.id}/edit")
    end

    it 'takes you to edit gallery info form when you click it' do
      click_link 'Update Art Piece Information'
      expect(page).to have_current_path("/pieces/#{@piece_1.id}/edit")
      expect(page).to have_content("Update #{@piece_1.name}")
    end
  end

  describe 'delete button on pieces show page and #delete method in pieces_controller' do
    before :each do
      visit "/pieces/#{@piece_1.id}"
    end
    it 'has a link to route a delete request' do
      expect(page).to have_link("Delete", href: "/pieces/#{@piece_1.id}")
    end

    it 'deletes the piece from the database and redirects to pieces index' do
      click_link "Delete"

      expect(current_path).to eq("/pieces")

      expect(page). to have_content(@piece_2.name)
      expect(page). to have_content(@piece_3.name)

      expect(page). to have_no_content(@piece_1.name)

      click_link @piece_2.name

      expect(current_path).to eq("/pieces/#{@piece_2.id}")

      click_link "Delete"

      expect(current_path).to eq("/pieces")

      expect(page). to have_content(@piece_3.name)

      expect(page). to have_no_content(@piece_2.name)
      expect(page). to have_no_content(@piece_1.name)
    end
  end
end
