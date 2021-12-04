require 'rails_helper'

RSpec.describe GalleriesController, type: :feature do
  before :each do
    @gallery_1 = Gallery.create!(name: "Art 4 Us", non_profit: true, entry_cost: 4.75)
    @gallery_2 = Gallery.create!(name: "Benji's Gallery", non_profit: false, entry_cost: 10)

    @piece_1 = @gallery_1.pieces.create!(name: "Starry Night", artist: "Vincent Van Gogh", year: 1889, original: false)
    @piece_2 = @gallery_1.pieces.create!(name: "Self Portrait", artist: "Vincent Van Gogh", year: 1889, original: true)
    @piece_3 = @gallery_2.pieces.create!(name: "Girl with the Pearl Earring", artist: "Johannes Vermeer", year: 1665, original: false)

    visit "galleries/"
    click_link "Art 4 Us"
  end
  
  describe 'Galleries show page' do
    it 'should visit the page at galleries/:id' do
      expect(page).to have_current_path("/galleries/#{@gallery_1.id}")
    end

    it 'displays gallery attributes on page' do
      expect(page).to have_content(@gallery_1.name)
      expect(page).to have_content('NPO Status: "Non-Profit"')
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
  end
end
