require 'rails_helper'

RSpec.describe PiecesController, type: :feature do
  before :each do
    @gallery_1 = Gallery.create!(name: "Art 4 Us", non_profit: true, entry_cost: 4.75)
    @gallery_2 = Gallery.create!(name: "Benji's Gallery", non_profit: false, entry_cost: 10)

    @piece_1 = Piece.create!(name: "Starry Night", artist: "Vincent Van Gogh", year: 1889, original: false, gallery_id: @gallery_1.id)
    @piece_2 = Piece.create!(name: "Self Portrait", artist: "Vincent Van Gogh", year: 1889, original: true, gallery_id: @gallery_1.id)
    @piece_3 = Piece.create!(name: "Girl with the Pearl Earring", artist: "Johannes Vermeer", year: 1665, original: false, gallery_id: @gallery_2.id)
    @piece_4 = Piece.create!(name: "Mona Lisa", artist: "Leonardo DaVinci", year: 1665, original: true, gallery_id: @gallery_2.id)

    visit "/pieces"
  end

  it 'can visit the website' do
    expect(page).to have_current_path("/pieces")
  end

  it 'displays each child with its attributes' do
    # expect(page).to have_content(@piece_1.name)
    # expect(page).to have_content(@piece_1.artist)
    # expect(page).to have_content("Reprint")
    # expect(page).to have_content(@piece_1.year)

    expect(page).to have_content(@piece_2.name)
    expect(page).to have_content(@piece_2.artist)
    expect(page).to have_content("Original")
    expect(page).to have_content(@piece_2.year)
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

  describe 'only original pieces display' do
    it 'only displays pieces with true boolean for original' do
      expect(page).to have_content(@piece_2.name)
    end

    it 'does not display pieces with boolean value falso for original' do
      expect(page).to have_no_content(@piece_3.name)
      expect(page).to have_no_content(@piece_1.name)
    end
  end

  describe 'edit piece info link' do
    it 'has a link that navigates to piece edit info page' do
      expect(page).to have_link("Edit", :href=>"/pieces/#{@piece_4.id}/edit")
      expect(page).to have_link("Edit", :href=>"/pieces/#{@piece_2.id}/edit")
    end

    it 'naviagtes to the edit page' do
      page.find(:css, "##{@piece_4.id}").click_on

      expect(current_path).to eq("/pieces/#{@piece_4.id}/edit")

      visit "/pieces"

      page.find(:css, "##{@piece_2.id}").click_on

      expect(current_path).to eq("/pieces/#{@piece_2.id}/edit")
    end
  end

  describe 'delete button on pieces index page' do
    it 'has a link to route a delete request' do
      expect(current_path).to eq("/pieces")
      expect(page).to have_link("Delete", href: "/pieces/#{@piece_2.id}")
      expect(page).to have_link("Delete", href: "/pieces/#{@piece_4.id}")
    end

    it 'deletes the piece from the database and redirects to pieces index' do
      page.find(:css, "#delete#{@piece_2.id}").click_on

      expect(page). to have_content(@piece_4.name)
      expect(page). to have_no_content(@piece_1.name)

      page.find(:css, "#delete#{@piece_4.id}").click_on

      expect(current_path).to eq("/pieces")

      expect(page). to have_no_content(@piece_2.name)
      expect(page). to have_no_content(@piece_4.name)
    end
  end
end
