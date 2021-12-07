require 'rails_helper'

RSpec.describe GalleriesController, type: :feature do
  before :each do
    @gallery_1 = Gallery.create!(name: "Art 4 Us", non_profit: true, entry_cost: 4.75)
    @gallery_2 = Gallery.create!(name: "Benji's Gallery", non_profit: false, entry_cost: 10)

    @piece_1 = @gallery_1.pieces.create!(name: "Starry Night", artist: "Vincent Van Gogh", year: 1889, original: false)
    @piece_2 = @gallery_1.pieces.create!(name: "Self Portrait", artist: "Vincent Van Gogh", year: 1889, original: true)
    @piece_3 = @gallery_2.pieces.create!(name: "Girl with the Pearl Earring", artist: "Johannes Vermeer", year: 1665, original: false)
    @piece_4 = @gallery_2.pieces.create!(name: "Mona Lisa", artist: "Leonardo DaVinci", year: 1665, original: true)

    visit "galleries/"
    click_link "Art 4 Us"
  end

  describe 'Galleries show page' do
    it 'should visit the page at galleries/:id' do
      expect(page).to have_current_path("/galleries/#{@gallery_1.id}")
    end

    it 'displays gallery attributes on page' do
      expect(page).to have_content(@gallery_1.name)
      expect(page).to have_content('NPO Status: Non-Profit')
      expect(page).to have_content("Cost of Entry: $#{@gallery_1.entry_cost}")
    end

    it 'shows count of number of pieces associated with gallery' do
      expect(page).to have_content("Number of Pieces: #{@gallery_1.total_pieces}")
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

    describe 'element specific to galleries#show page' do
      it 'has a nav element with links' do
        expect(page).to have_link("Current Exhibition", :href=>"/galleries/#{@gallery_1.id}/pieces")
      end

      it 'has link to art pieces index' do
        click_link "Current Exhibition"

        expect(page).to have_current_path("/galleries/#{@gallery_1.id}/pieces")

        expect(page).to have_content(@piece_1.name)
        expect(page).to have_content(@piece_2.name)
      end
    end
  end

  describe 'add new gallery link' do
    before :each do
      visit "/galleries"
    end

    it 'has link to new gallery page' do
      expect(page).to have_link("Add New Gallery", :href=>"/galleries/new")
    end

    it 'takes you to new gallery form when you click it' do
      click_link 'Add New Gallery'
      expect(page).to have_current_path('/galleries/new')
      expect(page).to have_content('Enter Gallery Information')
    end
  end

  describe 'update gallery info link' do
    before :each do
      visit "/galleries"
      click_link "Art 4 Us"
    end

    it 'has link to edit gallery info page' do
      expect(page).to have_link("Edit Gallery Info", :href=>"/galleries/#{@gallery_1.id}/edit")
    end

    it 'takes you to edit gallery info form when you click it' do
      click_link 'Edit Gallery Info'
      expect(page).to have_current_path("/galleries/#{@gallery_1.id}/edit")
      expect(page).to have_content('Update Gallery Information')
    end
  end

  describe 'delete button on page and controller delete method' do
    before :each do
      visit "/galleries/#{@gallery_1.id}"
    end

    it 'is a link on the galleries show page' do
      expect(page).to have_link("Delete", href: "/galleries/#{@gallery_1.id}")
    end

    it 'removes galleries and children when clicked' do
      expect(page).to have_content("#{@gallery_1.name}")
      expect(page).to have_content("Number of Pieces: 2")

      click_link "Delete"

      expect(current_path).to eq("/galleries")

      expect(page).to have_content("#{@gallery_2.name}")
      expect(page).to have_no_content("#{@gallery_1.name}")

      click_link "Art Pieces"

      expect(current_path).to eq("/pieces")

      expect(page).to have_content("#{@piece_4.name}")
      expect(page).to have_no_content("#{@piece_2.name}")
      expect(page).to have_no_content("#{@piece_1.name}")
    end
  end
end
