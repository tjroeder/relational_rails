require 'rails_helper'

RSpec.describe 'Project Welcome Page', type: :feature do
  before :each do
    visit '/'
  end

  it 'has author information' do
    expect(page).to have_content('Tim Roeder')
    expect(page).to have_content('Brad Breiten')
  end

  it 'has topic headings' do
    expect(page).to have_content('Authors')
    expect(page).to have_content('About')
    expect(page).to have_content('Projects')
  end

  it 'links to projects for each author' do
    expect(page).to have_link('Directors and Films Project', href: '/directors')
    expect(page).to have_link('Galleries and Pieces Project', href: '/galleries')
  end

  it 'goes to page when you click Tim link' do
    click_link 'Directors and Films Project'
    expect(current_path).to eq('/directors')
  end

  it 'goes to page when you click Brad link' do
    click_link 'Galleries and Pieces Project'
    expect(current_path).to eq('/galleries')
  end
end
