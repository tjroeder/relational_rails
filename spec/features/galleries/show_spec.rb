require 'rails_helper'

RSpec.describe GalleriesController, type: :feature do
  describe 'Galleries show page' do
    before :each do
      @gallery_1 = Gallery.create(name: "Art 4 Us", non_profit: true, entry_cost: 4.75)
      @gallery_2 = Gallery.create(name: "Benji's Gallery", non_profit: false, entry_cost: 10)

      visit "galleries/"
      click_link "Art 4 Us"
    end

    it 'should visit the page at galleries/:id' do
      expect(page).to have_current_path("/galleries/#{@gallery_1.id}")
    end

    it 'displays gallery attributes on page' do
      expect(page).to have_content(@gallery_1.name)
      expect(page).to have_content('NPO Status: "Non-Profit"')
      expect(page).to have_content("Cost of Entry: $#{@gallery_1.entry_cost}")
    end
  end
end
