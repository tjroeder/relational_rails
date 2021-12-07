require 'rails_helper'

RSpec.describe 'Art Piece Info Edit Form', type: :feature do
  before :each do
    @gallery_1 = Gallery.create!(name: "Art 4 Us", non_profit: true, entry_cost: 4.75, created_at: '2021-12-03 20:42:56 UTC')

    # @piece_1 = @gallery_1.pieces.create!(name: "Starry Night", artist: "Vincent Van Gogh", year: 1889, original: false)
    @piece_1 = @gallery_1.pieces.create!(name: "Starry Night", artist: "Vincent Van Gogh", year: 1889, original: true)

    visit "/pieces/#{@piece_1.id}/edit"
  end

  it 'already has attributes' do
    visit "/pieces"
    click_on "#{@piece_1.name}"

    expect(page).to have_content("#{@piece_1.name}")
    expect(page).to have_content("Artist: #{@piece_1.artist}")
    expect(page).to have_content("Year Created: #{@piece_1.year}")
    # expect(page).to have_content("Original?: Reprint")
    expect(page).to have_content("Original?: Original")
  end

  it 'has form heading' do
    expect(page).to have_content("Update #{@piece_1.name}")
  end

  it 'has fields for editing data' do
    expect(page).to have_field('piece[name]', with: "#{@piece_1.name}")
    expect(page).to have_field('piece[artist]', with: "#{@piece_1.artist}")
    expect(page).to have_field('piece[year]', with: "#{@piece_1.year}")
    expect(page).to have_field('piece[original]')
  end

  it 'updates piece info and redirects to piece show page when form is submitted' do
    fill_in 'piece[name]', with: 'Another Art Piece'
    fill_in 'piece[artist]', with: 'Another Person'
    fill_in 'piece[year]', with: '2021'
    choose('piece[original]', option: "true")
    click_on "Submit"

    expect(page).to have_current_path("/pieces/#{@piece_1.id}")
    expect(page).to have_content('Another Art Piece')
    expect(page).to have_content('Another Person')
    expect(page).to have_content('Year Created: 2021')
    expect(page).to have_content('Original?: Original')
  end

  it 'updates piece info and redirects to piece show page when form is submitted with false boolean value' do
    fill_in 'piece[name]', with: 'Another Art Piece'
    fill_in 'piece[artist]', with: 'Another Person'
    fill_in 'piece[year]', with: '2021'
    choose('piece[original]', option: "false")
    click_on "Submit"

    expect(page).to have_current_path("/pieces/#{@piece_1.id}")
    expect(page).to have_content('Another Art Piece')
    expect(page).to have_content('Another Person')
    expect(page).to have_content('Year Created: 2021')
    expect(page).to have_content('Original?: Reprint')
  end
end
