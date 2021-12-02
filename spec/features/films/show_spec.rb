require 'rails_helper'

RSpec.describe '/films/show.html.erb', type: :feature do
  let!(:director_1) { Director.create!(name: 'Wes Anderson', imdb_rank: 20, tv_credit: false) }
  let!(:director_2) { Director.create!(name: 'Steven Spielberg', imdb_rank: 1, tv_credit: true) }
  let!(:director_3) { Director.create!(name: 'George Lucas', imdb_rank: 25, tv_credit: true) }

  let!(:film_1) { director_1.films.create!(name: 'Bottle Rocket', rt_rank: 85, nominated: false) }
  let!(:film_2) { director_1.films.create!(name: 'Life Aquatic', rt_rank: 56, nominated: false) }
  let!(:film_3) { director_3.films.create!(name: 'Star Wars: A New Hope', rt_rank: 92, nominated: true)}

  describe 'as a user' do
    describe 'when I visit a films page' do
      it 'displays the films attributes' do
        visit "/films/#{film_1.id}"

        expect(page).to have_content(film_1.name)
        expect(page).to have_content(film_1.rt_rank)
        expect(page).to have_content(film_1.nominated)

        expect(page).to have_no_content(film_3.name)
        expect(page).to have_no_content(film_3.rt_rank)
        expect(page).to have_no_content(film_3.nominated)
      end
    end
  end
end