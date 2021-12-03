require 'rails_helper'

RSpec.describe '/director_films/index.html.erb', type: :feature do
  let!(:director_1) { Director.create!(name: 'Wes Anderson', imdb_rank: 20, tv_credit: false) }
  let!(:director_2) { Director.create!(name: 'Steven Spielberg', imdb_rank: 1, tv_credit: true) }
  let!(:director_3) { Director.create!(name: 'George Lucas', imdb_rank: 25, tv_credit: true) }

  let!(:film_1) { director_1.films.create!(name: 'Bottle Rocket', rt_rank: 85, nominated: false) }
  let!(:film_2) { director_1.films.create!(name: 'Life Aquatic', rt_rank: 56, nominated: false) }
  let!(:film_3) { director_3.films.create!(name: 'Star Wars: A New Hope', rt_rank: 92, nominated: true) }

  describe 'as a user' do
    describe 'when I visit directors films index' do
      it 'should visit the page at directors/:director_id/films' do
        visit "directors/#{director_1.id}/films"

        expect(page).to have_current_path("/directors/#{director_1.id}/films")
      end

      it 'displays directors films attributes' do
        visit "/directors/#{director_1.id}/films"
        
        expect(page).to have_content(film_1.name)
        expect(page).to have_content(film_2.name)
        expect(page).to have_content(film_1.rt_rank)
        expect(page).to have_content(film_2.rt_rank)
        expect(page).to have_content(film_1.nominated)
        expect(page).to have_content(film_2.nominated)
      end
      
      it 'does not display other films attributes' do
        visit "/directors/#{director_1.id}/films"
        
        expect(page).to have_no_content(film_3.name)
        expect(page).to have_no_content(film_3.rt_rank)
        expect(page).to have_no_content(film_3.nominated)
      end

      it 'displays a link called Films Index' do
        visit "/directors/#{director_1.id}/films"
        expect(page).to have_link("Films Index", :href=>"/films")

        visit "/directors/#{director_2.id}/films"
        expect(page).to have_link("Films Index", :href=>"/films")
        
        visit "/directors/#{director_3.id}/films"
        expect(page).to have_link("Films Index", :href=>"/films")
      end
    end

    describe 'can click links' do
      it 'redirect the user to the films index' do
        visit "/directors/#{director_1.id}/films"
        click_link 'Films Index'
        expect(page).to have_current_path("/films")

        visit "/directors/#{director_2.id}/films"
        click_link 'Films Index'
        expect(page).to have_current_path("/films")
        
        visit "/directors/#{director_3.id}/films"
        click_link 'Films Index'
        expect(page).to have_current_path("/films")
      end
    end
  end
end