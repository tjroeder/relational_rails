require 'rails_helper'

RSpec.describe '/films/show.html.erb', type: :feature do
  let!(:director_1) { Director.create!(name: 'Wes Anderson', imdb_rank: 20, tv_credit: false) }
  let!(:director_2) { Director.create!(name: 'Steven Spielberg', imdb_rank: 1, tv_credit: true) }
  let!(:director_3) { Director.create!(name: 'George Lucas', imdb_rank: 25, tv_credit: true) }

  let!(:film_1) { director_1.films.create!(name: 'Bottle Rocket', rt_rank: 85, nominated: false) }
  let!(:film_2) { director_1.films.create!(name: 'Life Aquatic', rt_rank: 56, nominated: false) }
  let!(:film_3) { director_3.films.create!(name: 'Star Wars: A New Hope', rt_rank: 92, nominated: true) }

  describe 'as a user' do
    describe 'when I visit a films page' do
      it 'should visit the page at films/:id' do
        visit "/films/#{film_1.id}"

        expect(page).to have_current_path("/films/#{film_1.id}")
      end

      it 'displays the films attributes' do
        visit "/films/#{film_1.id}"

        expect(page).to have_content(film_1.name)
        expect(page).to have_content(film_1.rt_rank)
        expect(page).to have_content(film_1.nominated)

        expect(page).to have_no_content(film_3.name)
        expect(page).to have_no_content(film_3.rt_rank)
        expect(page).to have_no_content(film_3.nominated)
      end

      it 'displays a link called Films Index' do
        visit "/films/#{film_1.id}"
        expect(page).to have_link("Films Index", href: "/films")

        visit "/films/#{film_2.id}"
        expect(page).to have_link("Films Index", href: "/films")
        
        visit "/films/#{film_3.id}"
        expect(page).to have_link("Films Index", href: "/films")
      end

      it 'displays a link called Directors Index' do
        visit "/films/#{film_1.id}"
        expect(page).to have_link("Directors Index", href: "/directors")

        visit "/films/#{film_2.id}"
        expect(page).to have_link("Directors Index", href: "/directors")
        
        visit "/films/#{film_3.id}"
        expect(page).to have_link("Directors Index", href: "/directors")
      end

      it 'displays a link called update film' do
        visit "/films/#{film_1.id}"

        expect(page).to have_link("Update Film", href: "/films/#{film_1.id}/edit")
      end

      it 'displays a button called Destroy Film' do
        visit "/films/#{film_1.id}"
        
        expect(page).to have_button("Delete Film")
      end
    end

    describe 'can click links or buttons' do
      it 'redirect the user to the Films index' do
        visit "/films/#{film_1.id}"
        click_link 'Films Index'
        expect(page).to have_current_path("/films")

        visit "/films/#{film_2.id}"
        click_link 'Films Index'
        expect(page).to have_current_path("/films")
        
        visit "/films/#{film_3.id}"
        click_link 'Films Index'
        expect(page).to have_current_path("/films")
      end

      it 'redirect the user to the Directors index' do
        visit "/films/#{film_1.id}"
        click_link 'Directors Index'
        expect(page).to have_current_path("/directors")

        visit "/films/#{film_2.id}"
        click_link 'Directors Index'
        expect(page).to have_current_path("/directors")
        
        visit "/films/#{film_3.id}"
        click_link 'Directors Index'
        expect(page).to have_current_path("/directors")
      end

      it 'redirect the user to the film editor' do
        visit "/films/#{film_1.id}"
        click_link 'Update Film'

        expect(page).to have_current_path("/films/#{film_1.id}/edit")
      end

      it 'redirect the user to the film index after deleting film' do
        visit "/films/#{film_1.id}"
        click_button 'Delete Film'

        expect(page).to have_current_path('/films')
      end

      it 'deletes the film after select delete film button' do
        film_4 = director_1.films.create!(name: 'Isle of Dogs', rt_rank: 47, nominated: true)

        visit "/films/#{film_3.id}"
        click_button 'Delete Film'

        expect(page).to have_content(film_4.name)
        expect(page).to have_content(film_4.rt_rank)
        expect(page).to have_no_content(film_3.name)
        expect(page).to have_no_content(film_3.rt_rank)
      end
    end
  end
end