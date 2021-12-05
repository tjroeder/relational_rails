require 'rails_helper'

RSpec.describe '/films/index.html.erb', type: :feature do
  let!(:director_1) { Director.create!(name: 'Wes Anderson', imdb_rank: 20, tv_credit: false) }
  let!(:director_2) { Director.create!(name: 'Steven Spielberg', imdb_rank: 1, tv_credit: true) }
  let!(:director_3) { Director.create!(name: 'George Lucas', imdb_rank: 25, tv_credit: true) }

  let!(:film_1) { director_1.films.create!(name: 'Bottle Rocket', rt_rank: 85, nominated: false) }
  let!(:film_2) { director_1.films.create!(name: 'Life Aquatic', rt_rank: 56, nominated: false) }
  let!(:film_3) { director_3.films.create!(name: 'Star Wars: A New Hope', rt_rank: 92, nominated: true) }
  let!(:film_4) { director_3.films.create!(name: 'Star Wars: Empire Strikes Back', rt_rank: 1, nominated: true) }
  
  describe 'as a user' do
    describe 'when I visit the films index' do
      it 'should visit the page at /films/' do
        visit '/films'
        
        expect(page).to have_current_path('/films')
      end

      it 'displays films names with nominated status' do
        visit '/films'

        expect(page).to have_content(film_3.name)
        expect(page).to have_content(film_4.name)
      end
      
      it 'displays films RT rank with nominated status' do
        visit '/films'
        
        expect(page).to have_content(film_3.rt_rank)
        expect(page).to have_content(film_4.rt_rank)
      end

      it 'displays films with nominated status' do
        visit '/films'
        
        expect(page).to have_content(film_3.nominated)
        expect(page).to have_content(film_4.nominated)
      end

      it 'displays a link called Films Index' do
        visit '/films'

        expect(page).to have_link("Films Index", :href=>"/films")
      end

      it 'displays a link called Directors Index' do
        visit '/films'

        expect(page).to have_link("Directors Index", :href=>"/directors")
      end
    end

    describe 'can click links' do
      it 'redirect the user to the films index' do
        visit '/films'
        click_link 'Films Index'
        
        expect(page).to have_current_path("/films")
      end

      it 'redirect the user to the directors index' do
        visit '/films'
        click_link 'Directors Index'
        
        expect(page).to have_current_path("/directors")
      end
    end
  end
end