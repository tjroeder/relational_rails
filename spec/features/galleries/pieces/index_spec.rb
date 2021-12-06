require 'rails_helper'

RSpec.describe 'Gallery pieces index' do
  before :each do
    @gallery_1 = Gallery.create!(name: "Art 4 Us", non_profit: true, entry_cost: 4.75)
    @gallery_2 = Gallery.create!(name: "Benji's Gallery", non_profit: false, entry_cost: 10)

    @piece_1 = @gallery_1.pieces.create!(name: "Starry Night", artist: "Vincent Van Gogh", year: 1889, original: false)
    @piece_2 = @gallery_1.pieces.create!(name: "Self Portrait", artist: "Vincent Van Gogh", year: 1889, original: true)
    @piece_3 = @gallery_2.pieces.create!(name: "Girl with the Pearl Earring", artist: "Johannes Vermeer", year: 1665, original: false)

    visit "/galleries/#{@gallery_1.id}/pieces"
  end

  it 'shows all pieces associated with a gallery' do
    expect(page).to have_content(@piece_1.name)
    expect(page).to have_content(@piece_2.name)
  end

  it 'shows all the child attributes' do
    expect(page).to have_content(@piece_1.artist)
    expect(page).to have_content(@piece_1.year)
    expect(page).to have_content("Reprint")

    expect(page).to have_content(@piece_2.artist)
    expect(page).to have_content(@piece_2.year)
    expect(page).to have_content("Original")
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

  describe 'add new pieces link' do
    it 'has link to add new piece page' do
      expect(page).to have_link("Add New Piece", :href=>"/galleries/#{@gallery_1.id}/pieces/new")
    end

    it 'takes you to add new piece form when you click it' do
      click_link 'Add New Piece'

      expect(page).to have_current_path("/galleries/#{@gallery_1.id}/pieces/new")
      expect(page).to have_content("Add New Piece to #{@gallery_1.name}")
    end
  end

  describe 'sort alphabetically link' do
    it 'has a link to sort alphabetically' do
      expect(page).to have_link('Sort Alphabetically', :href=>"/galleries/#{@gallery_1.id}/pieces?sort=asc")
    end

    it 'sorts pieces alphabetically by name' do
      piece_4 = @gallery_1.pieces.create!(name: "ZZZZZ", artist: "Johannes Vermeer", year: 1665, original: false)
      piece_5 = @gallery_1.pieces.create!(name: "AAAAAA", artist: "Johannes Vermeer", year: 1665, original: false)

      visit "/galleries/#{@gallery_1.id}/pieces"
      click_link "Sort Alphabetically"

      expect(piece_5.name).to appear_before(@piece_2.name, only_text: true)
      expect(@piece_2.name).to appear_before(@piece_1.name, only_text: true)
      expect(@piece_1.name).to appear_before(piece_4.name, only_text: true)
    end
  end
end
