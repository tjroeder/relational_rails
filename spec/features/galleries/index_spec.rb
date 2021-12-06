require 'rails_helper'

RSpec.describe GalleriesController, type: :feature do
  before :each do
    @gallery_1 = Gallery.create!(name: "Art 4 Us", non_profit: true, entry_cost: 4.75, created_at: '2021-12-03 20:42:56 UTC')

    @gallery_2 = Gallery.create!(name: "Benji's Gallery", non_profit: false, entry_cost: 10, created_at: '2021-12-03 20:43:52 UTC')

    visit '/galleries'
  end

  describe 'instance methods' do
    it 'should visit the page at galleries/:id' do
      expect(page).to have_current_path("/galleries")
    end

    it 'displays name of each parent record in the system' do
      expect(page).to have_content(@gallery_1.name)
      expect(page).to have_content(@gallery_2.name)
    end

    it 'orders the galleries index by date created from most recent to first created' do
      expect("Benji's Gallery").to appear_before("Art 4 Us", only_text: true)
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

  describe 'gellery page index link' do
    it 'has a link that goes to edit page' do
      expect(page).to have_link("Edit #{@gallery_1.name} Info", :href=>"/galleries/#{@gallery_1.id}/edit")
    end

    it 'navigates to gallery info edit form page' do
      click_link "Edit #{@gallery_1.name} Info"

      expect(current_path).to eq("/galleries/#{@gallery_1.id}/edit")
    end
  end
end
