require 'rails_helper'

RSpec.describe 'Gallery Info Edit Form', type: :feature do
  before :each do
    @gallery_1 = Gallery.create!(name: "Art 4 Us", non_profit: true, entry_cost: 4.75, created_at: '2021-12-03 20:42:56 UTC')

    visit "/galleries/#{@gallery_1.id}/edit"
  end

  it 'already has attributes' do
    visit "/galleries"
    click_on "Art 4 Us"

    expect(page).to have_content('Edit Gallery Info')
    expect(page).to have_content('Cost of Entry: $4.75')
  end

  it 'has form heading' do
    expect(page).to have_content('Update Gallery Information')
  end

  it 'has fields for editing data' do
    expect(page).to have_field('gallery[name]', with: "#{@gallery_1.name}")
    expect(page).to have_field('gallery[entry_cost]', with: "4.75")
    expect(page).to have_field('gallery[non_profit]')
  end

  it 'updates gallery and redirects to show page when form is submitted' do
    fill_in 'gallery[name]', with: 'Art Macfarlande'
    fill_in 'gallery[entry_cost]', with: '3.33'
    click_on "Submit"

    expect(page).to have_current_path("/galleries/#{@gallery_1.id}")
    expect(page).to have_content('Art Macfarlande')
    expect(page).to have_content('Cost of Entry: $3.33')
    expect(page).to have_content('NPO Status: Non-Profit')
  end
end
