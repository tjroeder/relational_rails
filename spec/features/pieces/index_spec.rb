require 'rails_helper'

RSpec.describe PiecesController, type: :feature do
  before :each do
    @gallery_1 = Gallery.create!(name: "Art 4 Us", non_profit: true, entry_cost: 4.75)
    @gallery_2 = Gallery.create!(name: "Benji's Gallery", non_profit: false, entry_cost: 10)
    @piece_1 = Piece.create!(name: "Starry Night", artist: "Vincent Van Gogh", year: 1889, original: false, gallery_id: @gallery_1.id)
    @piece_2 = Piece.create!(name: "Self Portrait", artist: "Vincent Van Gogh", year: 1889, original: true, gallery_id: @gallery_1.id)
    @piece_3 = Piece.create!(name: "Girl with the Pearl Earring", artist: "Johannes Vermeer", year: 1665, original: false, gallery_id: @gallery_2.id)

    visit "/pieces"
  end

  it 'can visit the website' do
    expect(page).to have_current_path("/pieces")
  end

  it 'displays each child with its attributes' do
    expect(page).to have_content(@piece_1.name)
    expect(page).to have_content(@piece_1.artist)
    expect(page).to have_content("Original")
    expect(page).to have_content(@piece_1.year)

    expect(page).to have_content(@piece_2.name)
    expect(page).to have_content(@piece_2.artist)
    expect(page).to have_content("Reprint")
    expect(page).to have_content(@piece_2.year)
  end

end