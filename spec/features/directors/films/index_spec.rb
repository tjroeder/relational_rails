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

        expect(page).to have_link("Films Index", href: "/films")
      end

      it 'displays a link called Directors Index' do
        visit "/directors/#{director_1.id}/films"

        expect(page).to have_link("Directors Index", href: "/directors")
      end

      it 'displays a link called create film' do
        visit "/directors/#{director_1.id}/films"
        
        expect(page).to have_link("Create Film", href: "/directors/#{director_1.id}/films/new")
      end

      it 'displays a link to sort alphabetically' do
        visit "/directors/#{director_1.id}/films"

        expect(page).to have_link("Sort alphabetical", href: "/directors/#{director_1.id}/films?sort=asc")
      end

      it 'displays a link called Edit Film' do
        visit "/directors/#{director_1.id}/films"

        expect(page).to have_link("Edit Film", href: "/films/#{film_1.id}/edit")
      end

      it 'displays input fields' do
        visit "/directors/#{director_1.id}/films"

        expect(page).to have_field('Filter by Rotten Tomatoes Rank:', type: 'number')
      end
    end

    describe 'can click links' do
      it 'redirect the user to the films index' do
        visit "/directors/#{director_1.id}/films"
        click_link 'Films Index'

        expect(page).to have_current_path("/films")
      end

      it 'redirect the user to the directors index' do
        visit "/directors/#{director_1.id}/films"
        click_link 'Directors Index'
        
        expect(page).to have_current_path("/directors")
      end

      it 'redirect the user to create new film' do
        visit "/directors/#{director_1.id}/films"
        click_link 'Create Film'
        
        expect(page).to have_current_path("/directors/#{director_1.id}/films/new")
      end

      it 'can reload the page with films sorted alphabetically' do
        film_4 = director_1.films.create!(name: 'Darjeeling Limited', rt_rank: 47, nominated: true)
        
        visit "/directors/#{director_1.id}/films"
        expect(film_1.name).to appear_before(film_2.name)
        expect(film_1.name).to appear_before(film_4.name)
        expect(film_2.name).to appear_before(film_4.name)
        
        click_link 'Sort alphabetical'
        expect(page).to have_current_path("/directors/#{director_1.id}/films?sort=asc")
        expect(film_1.name).to appear_before(film_4.name)
        expect(film_1.name).to appear_before(film_2.name)
        expect(film_4.name).to appear_before(film_2.name)
      end
      
      it 'redirect the user to edit film' do
        visit "/directors/#{director_1.id}/films"
        page.find(:css, "#edit-#{film_1.id}").click_on
        
        expect(page).to have_current_path("/films/#{film_1.id}/edit")
      end
      
      it 'can reload the page with films filtered by user selected rt_rank' do
        film_4 = director_1.films.create!(name: 'Darjeeling Limited', rt_rank: 47, nominated: true)
        film_5 = director_1.films.create!(name: 'Moonrise Kingdom', rt_rank: 60, nominated: true)
        film_6 = director_1.films.create!(name: 'Isle of Dogs', rt_rank: 61, nominated: true)

        visit "/directors/#{director_1.id}/films"
        fill_in 'filter', with: 60
        click_button 'Filter'

        expect(page).to have_current_path("/directors/#{director_1.id}/films?utf8=%E2%9C%93&filter=60&commit=Filter")
        expect(page).to have_content(film_1.name)
        expect(page).to have_content(film_6.name)
      end
    end
  end
end