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
end
