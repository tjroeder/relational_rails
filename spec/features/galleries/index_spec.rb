require 'rails_helper'

RSpec.describe GalleriesController, type: :feature do
  describe 'instance methods' do
    it 'should visit the page at galleries/:id' do
      visit '/galleries'

      expect(page).to have_current_path("/galleries")
    end

    it 'displays name of each parent record in the system' do
      gallery_1 = Gallery.create!(name: "Art 4 Us", non_profit: true, entry_cost: 4.75, created_at: '2021-12-03 20:42:56 UTC')

      gallery_2 = Gallery.create!(name: "Benjis Gallery", non_profit: false, entry_cost: 10, created_at: '2021-12-03 20:43:52 UTC')

      visit '/galleries'

      expect(page).to have_content(gallery_1.name)
      expect(page).to have_content(gallery_2.name)
    end

    it 'orders the galleries index by date created from most recent to first created' do
      gallery_1 = Gallery.create!(name: "Art 4 Us", non_profit: true, entry_cost: 4.75, created_at: '2021-12-03 20:42:56 UTC')

      gallery_2 = Gallery.create!(name: "Benji's Gallery", non_profit: false, entry_cost: 10, created_at: '2021-12-03 20:43:52 UTC')

      visit '/galleries'

      expect("Benji's Gallery").to appear_before("Art 4 Us", only_text: true)
    end
  end
end
