require 'rails_helper'

RSpec.describe '/directors/:id/edit', type: :feature do
  let!(:director_1) { Director.create!(name: 'Wes Anderson', imdb_rank: 20, tv_credit: false) }

  describe 'as a user' do
    describe 'when I visit the page at /directors/:id/edit' do
      it 'has input forms for updating the director' do
        visit "/directors/#{director_1.id}"
        click_on 'Update Director'

        expect(page).to have_field('Director Full Name:')
        expect(page).to have_field('IMDB Ranking:')
        expect(page).to have_field('TV Credit:')
      end
    end

    describe 'when they fill in the input forms' do
      it 'updates the Director with new info and returns to /directors/:id' do
        visit "/directors/#{director_1.id}"
        click_on 'Update Director'

        fill_in :name, with: 'Dennis Villeneuve'
        fill_in :imdb_rank, with: 30
        select 'Yes', from: :tv_credit
        click_on 'Update Director'

        expect(page).to have_current_path("/directors/#{director_1.id}")
        expect(page).to have_content('Dennis Villeneuve')
        expect(page).to have_content('30')
        expect(page).to have_content('true')
      end
    end
  end
end