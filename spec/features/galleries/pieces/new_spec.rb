require 'rails_helper'

RSpec.describe 'Add Piece to Gallery Form', type: :feature do
  before :each do
    @gallery_1 = Gallery.create!(name: "Art 4 Us", non_profit: true, entry_cost: 4.75)

    @piece_1 = @gallery_1.pieces.create!(name: "Starry Night", artist: "Vincent Van Gogh", year: 1889, original: false)
    @piece_2 = @gallery_1.pieces.create!(name: "Self Portrait", artist: "Vincent Van Gogh", year: 1889, original: true)

    visit "/galleries/#{@gallery_1.id}/pieces/new"
  end

  it 'has form heading' do
    expect(page).to have_content("Add New Piece to #{@gallery_1.name}")
  end

  it 'has fields for inputting data' do
    expect(page).to have_field('piece[name]')
    expect(page).to have_field('piece[artist]')
    expect(page).to have_field('piece[year]')
  end

  it 'updates galleries index when form is submitted' do
    fill_in 'piece[name]', with: 'Moaning Lisa'
    fill_in 'piece[artist]', with: 'Leonard FlaDinci'
    fill_in 'piece[year]', with: '1503'
    click_on "Submit"

    expect(page).to have_current_path("/galleries/#{@gallery_1.id}/pieces")
    expect(page).to have_content('Moaning Lisa')
    expect(page).to have_content("Leonard FlaDinci")
    expect(page).to have_content("1503")
  end
end
