require 'rails_helper'

RSpec.describe '/films/index.html.erb', type: :feature do
  let!(:director_1) { Director.create!(name: 'Wes Anderson', imdb_rank: 20, tv_credit: false) }
  let!(:director_2) { Director.create!(name: 'Steven Spielberg', imdb_rank: 1, tv_credit: true) }
  let!(:director_3) { Director.create!(name: 'George Lucas', imdb_rank: 25, tv_credit: true) }

  let!(:film_1) { director_1.films.create!(name: 'Bottle Rocket', rt_rank: 85, nominated: false) }
  let!(:film_2) { director_1.films.create!(name: 'Life Aquatic', rt_rank: 56, nominated: false) }
  let!(:film_3) { director_3.films.create!(name: 'Star Wars: A New Hope', rt_rank: 92, nominated: true)}
  
  describe 'as a user' do
    describe 'when I visit the films index' do
      it 'should visit the page at /films/' do
        visit '/films'

        expect(page).to have_current_path('/films')
      end

      it 'displays all the films names' do
        visit '/films'

        expect(page).to have_content(film_1.name)
        expect(page).to have_content(film_2.name)
        expect(page).to have_content(film_3.name)
      end
      
      it 'displays all the films RT rank' do
        visit '/films'
        
        expect(page).to have_content(film_1.rt_rank)
        expect(page).to have_content(film_2.rt_rank)
        expect(page).to have_content(film_3.rt_rank)
      end

      it 'displays all the films nominated status' do
        visit '/films'
        
        expect(page).to have_content(film_1.nominated)
        expect(page).to have_content(film_2.nominated)
        expect(page).to have_content(film_3.nominated)
      end
    end
  end
end