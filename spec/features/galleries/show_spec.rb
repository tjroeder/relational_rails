require 'rails_helper'

RSpec.describe GalleriesController, type: :feature do
  describe 'Galleries show page' do
    before :each do
      @gallery_1 = Gallery.create(name: "Art 4 Us", non_profit: true, entry_cost: 4.75)
      @gallery_2 = Gallery.create(name: "Benji's Gallery", non_profit: false, entry_cost: 10)

      visit 'galleries/:id'
    end
    it 'should have a page at parents/:id' do
      expect(page).to have_current_path('/galleries/:id')
    end


  end
end
