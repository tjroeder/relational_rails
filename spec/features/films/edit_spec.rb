require 'rails_helper'

RSpec.describe '/films/:id/edit', type: :feature do
  let!(:director_1) { Director.create!(name: 'Wes Anderson', imdb_rank: 20, tv_credit: false) }
  let!(:director_2) { Director.create!(name: 'Steven Spielberg', imdb_rank: 1, tv_credit: true) }
  let!(:director_3) { Director.create!(name: 'George Lucas', imdb_rank: 25, tv_credit: true) }

  let!(:film_1) { director_1.films.create!(name: 'Bottle Rocket', rt_rank: 85, nominated: false) }
  let!(:film_2) { director_1.films.create!(name: 'Life Aquatic', rt_rank: 56, nominated: false) }
  let!(:film_3) { director_3.films.create!(name: 'Star Wars: A New Hope', rt_rank: 92, nominated: true) }

  describe 'as a user' do
    describe 'when I visit the page at /films/:id/edit' do
      it 'has input forms for updating the Film' do
        visit "/films/#{film_1.id}"
        click_on 'Update Film'

        expect(page).to have_field('Film Name:')
        expect(page).to have_field('Rotten Tomatoes Rank:')
        expect(page).to have_field('Award Nominated Film:')
      end
    end

    describe 'when they fill in the input forms' do
      it 'updates the Film with new info and returns them to /films/:id' do
        visit "/films/#{film_1.id}"
        click_on 'Update Film'

        fill_in :name, with: 'Moonrise Kingdom'
        fill_in :rt_rank, with: 44
        select 'Yes', from: :nominated
        click_on 'Update Film'

        expect(page).to have_current_path("/films/#{film_1.id}")
        expect(page).to have_content('Moonrise Kingdom')
        expect(page).to have_content('Rotten Tomatoes Rank: 44')
        expect(page).to have_content('Award Nominated Film: true')
      end
    end
  end
end