require 'rails_helper'

RSpec.describe '/directors/:director_id/films/new', type: :feature do
  let!(:director_1) { Director.create!(name: 'Wes Anderson', imdb_rank: 20, tv_credit: false) }

  describe 'as a user' do
    describe 'when I visit the page at /directors/:director_id/films/new' do
      it 'has input forms for creating a new director film' do
        visit "/directors/#{director_1.id}/films"
        click_on 'Create Film'

        expect(page).to have_field('Film Name:')
        expect(page).to have_field('Rotten Tomatoes Rank:')
        expect(page).to have_field('Award Nominated Film:')
      end

      it 'creates a new director film and returns to /directors/:director_id/films' do
        visit "/directors/#{director_1.id}/films"
        click_on 'Create Film'

        fill_in :name, with: 'The Royal Tenenbaums'
        fill_in :rt_rank, with: 23
        select 'Yes', from: :nominated
        click_on 'Create Film'

        expect(page).to have_current_path("/directors/#{director_1.id}/films")
        expect(page).to have_content('The Royal Tenenbaums')
        expect(page).to have_content('Rotten Tomatoes Rank: 23')
        expect(page).to have_content('Award Nominated Film: true')
      end
    end
  end
end