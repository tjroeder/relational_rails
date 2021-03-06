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
    expect(page).to have_field('name')
    expect(page).to have_field('artist')
    expect(page).to have_field('year')
    expect(page).to have_field('original')
  end

  it 'has field headings' do
    expect(page).to have_content('Name of Piece')
    expect(page).to have_content('Artist:')
    expect(page).to have_content('Year Created:')
    expect(page).to have_content('Is it an Original Piece:')
    expect(page).to have_content('Original Other')
  end

  it 'updates gallery pieces index when form is submitted' do
    fill_in 'name', with: 'Moaning Lisa'
    fill_in 'artist', with: 'Leonard FlaDinci'
    fill_in 'year', with: '1503'
    choose('original', option: "true")
    click_on "Submit"

    expect(page).to have_current_path("/galleries/#{@gallery_1.id}/pieces")
    expect(page).to have_content('Moaning Lisa')
    expect(page).to have_content("Leonard FlaDinci")
    expect(page).to have_content("1503")
    expect(page).to have_content("Original?: Original")
    expect("Moaning Lisa").to appear_before("Add New Piece", only_text: true)
    expect(@piece_1.name).to appear_before("Moaning Lisa", only_text: true)
  end

  it 'checks for false boolean in original' do
    gallery_2 = Gallery.create!(name: "Billy Bob Art", non_profit: true, entry_cost: 4.75)
    visit "/galleries/#{gallery_2.id}/pieces/new"

    fill_in 'name', with: 'Moaning Lisa'
    fill_in 'artist', with: 'Leonard FlaDinci'
    fill_in 'year', with: '1503'
    choose('original', option: "false")
    click_on "Submit"

    expect(page).to have_current_path("/galleries/#{gallery_2.id}/pieces")
    expect(page).to have_content('Moaning Lisa')
    expect(page).to have_content("Leonard FlaDinci")
    expect(page).to have_content("1503")
    expect(page).to have_content("Original?: Reprint")
    expect("Moaning Lisa").to appear_before("Add New Piece", only_text: true)
  end
end
