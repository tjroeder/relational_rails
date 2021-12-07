require 'rails_helper'

RSpec.describe 'New Gallery Form', type: :feature do
  before :each do
    visit '/galleries/new'
  end

  it 'has form heading' do
    expect(page).to have_content('Enter Gallery Information')
  end

  it 'has fields for inputting data' do
    expect(page).to have_field('gallery[name]')
    expect(page).to have_field('gallery[entry_cost]')
    expect(page).to have_field('gallery[non_profit]')
  end

  it 'updates galleries index when form is submitted' do
    fill_in 'gallery[name]', with: 'Art Macfarlande'
    fill_in 'gallery[entry_cost]', with: '3.33'
    click_on "Submit"

    expect(page).to have_current_path("/galleries")
    expect(page).to have_content('Art Macfarlande')
    expect(page).to have_link("Art Macfarlande")

    click_link "Art Macfarlande"
    expect(page).to have_content('NPO Status: Non-Profit')
    expect("Art Macfarlande").to appear_before("Edit Gallery Info", only_text: true)

  end

  it 'updates galleries index with false boolean value when selected and when form is submitted' do
    fill_in 'gallery[name]', with: 'Art Macfarlande'
    fill_in 'gallery[entry_cost]', with: '3.33'
    choose('gallery[non_profit]', option: "false")
    click_on "Submit"

    expect(page).to have_current_path("/galleries")
    expect(page).to have_content('Art Macfarlande')
    expect(page).to have_link("Art Macfarlande")

    click_link "Art Macfarlande"

    expect(page).to have_content('NPO Status: Private')
    expect("Art Macfarlande").to appear_before("Edit Gallery Info", only_text: true)
  end
end
