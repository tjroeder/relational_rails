require 'rails_helper'

RSpec.describe '/directors/show.html.erb', type: :feature do
  let!(:director_1) { Director.create!(name: 'Wes Anderson', imdb_rank: 20, tv_credit: false) }
  let!(:director_2) { Director.create!(name: 'Steven Spielberg', imdb_rank: 1, tv_credit: true) }
  let!(:director_3) { Director.create!(name: 'George Lucas', imdb_rank: 25, tv_credit: true) }

  let!(:film_1) { director_1.films.create!(name: 'Bottle Rocket', rt_rank: 85, nominated: false) }
  let!(:film_2) { director_1.films.create!(name: 'Life Aquatic', rt_rank: 56, nominated: false) }
  let!(:film_3) { director_3.films.create!(name: 'Star Wars: A New Hope', rt_rank: 92, nominated: true) }

  describe 'as a user' do
    describe 'when I visit the director id' do
      it 'should visit the page at /directors/:id' do
        visit "/directors/#{director_1.id}"

        expect(page).to have_current_path("/directors/#{director_1.id}")
      end

      it 'shows attributes for the director' do
        visit "/directors/#{director_1.id}"
        
        expect(page).to have_content(director_1.name)
        expect(page).to have_content(director_1.imdb_rank)
        expect(page).to have_content(director_1.tv_credit)
        
        visit "/directors/#{director_2.id}"

        expect(page).to have_content(director_2.name)
        expect(page).to have_content(director_2.imdb_rank)
        expect(page).to have_content(director_2.tv_credit)
      end

      it 'displays the count of the directors films' do
        visit "/directors/#{director_1.id}"
        expect(page).to have_content(director_1.films.size)
        
        visit "/directors/#{director_2.id}"
        expect(page).to have_content(director_2.films.size)

        visit "/directors/#{director_3.id}"
        expect(page).to have_content(director_3.films.size)
      end
      
      it 'displays a link called Films Index' do
        visit "/directors/#{director_1.id}"
        expect(page).to have_link("Films Index", href: "/films")

        visit "/directors/#{director_2.id}"
        expect(page).to have_link("Films Index", href: "/films")
        
        visit "/directors/#{director_3.id}"
        expect(page).to have_link("Films Index", href: "/films")
      end

      it 'displays a link called Directors Index' do
        visit "/directors/#{director_1.id}"
        expect(page).to have_link("Directors Index", href: "/directors")

        visit "/directors/#{director_2.id}"
        expect(page).to have_link("Directors Index", href: "/directors")
        
        visit "/directors/#{director_3.id}"
        expect(page).to have_link("Directors Index", href: "/directors")
      end

      it 'displays a link called Directors name films Index' do
        visit "/directors/#{director_1.id}"
        expect(page).to have_link("#{director_1.name}'s Films Index", href: "/directors/#{director_1.id}/films")

        visit "/directors/#{director_2.id}"
        expect(page).to have_link("#{director_2.name}'s Films Index", href: "/directors/#{director_2.id}/films")
        
        visit "/directors/#{director_3.id}"
        expect(page).to have_link("#{director_3.name}'s Films Index", href: "/directors/#{director_3.id}/films")
      end

      it 'displays a link called Update Director' do
        visit "/directors/#{director_1.id}"
        expect(page).to have_link("Update Director", href: "/directors/#{director_1.id}/edit")

        visit "/directors/#{director_2.id}"
        expect(page).to have_link("Update Director", href: "/directors/#{director_2.id}/edit")

        visit "/directors/#{director_3.id}"
        expect(page).to have_link("Update Director", href: "/directors/#{director_3.id}/edit")
      end

      it 'displays a link called Delete Director' do
        visit "/directors/#{director_1.id}"
        expect(page).to have_button("Delete Director")
        
        visit "/directors/#{director_2.id}"
        expect(page).to have_button("Delete Director")

        visit "/directors/#{director_3.id}"
        expect(page).to have_button("Delete Director")
      end
    end

    describe 'can click links' do
      it 'redirects the user to the Films index' do
        visit "/directors/#{director_1.id}"
        click_link 'Films Index'
        expect(page).to have_current_path("/films")

        visit "/directors/#{director_2.id}"
        click_link 'Films Index'
        expect(page).to have_current_path("/films")
        
        visit "/directors/#{director_3.id}"
        click_link 'Films Index'
        expect(page).to have_current_path("/films")
      end

      it 'redirects the user to the Directors index' do
        visit "/directors/#{director_1.id}"
        click_link 'Directors Index'
        expect(page).to have_current_path("/directors")

        visit "/directors/#{director_2.id}"
        click_link 'Directors Index'
        expect(page).to have_current_path("/directors")
        
        visit "/directors/#{director_3.id}"
        click_link 'Directors Index'
        expect(page).to have_current_path("/directors")
      end

      it 'redirects the user to the Directors name films index' do
        visit "/directors/#{director_1.id}"
        click_link "#{director_1.name}'s Films Index"
        expect(page).to have_current_path("/directors/#{director_1.id}/films")

        visit "/directors/#{director_2.id}"
        click_link "#{director_2.name}'s Films Index"
        expect(page).to have_current_path("/directors/#{director_2.id}/films")
        
        visit "/directors/#{director_3.id}"
        click_link "#{director_3.name}'s Films Index"
        expect(page).to have_current_path("/directors/#{director_3.id}/films")
      end

      it 'redirects the user to the Directors edit page' do
        visit "/directors/#{director_1.id}"
        click_link 'Update Director'

        expect(page).to have_current_path("/directors/#{director_1.id}/edit")
      end

      it 'redirects the user to the Directors index after deleting director' do
        visit "/directors/#{director_1.id}"
        click_button 'Delete Director'

        expect(page).to have_current_path('/directors')
      end

      it 'deletes director and directors films after select Delete Director' do
        film_4 = director_3.films.create!(name: 'Star Wars: Empire Strikes Back', rt_rank: 1, nominated: true)
        film_5 = director_2.films.create!(name: 'Schindlers List', rt_rank: 2, nominated: true)

        visit "/directors/#{director_3.id}"
        click_button 'Delete Director'

        expect(page).to have_no_content(director_3.name)
        expect(page).to have_no_content(director_3.imdb_rank)
        
        visit "/films"
        expect(page).to have_content(film_5.name)
        expect(page).to have_content(film_5.rt_rank)
        expect(page).to have_no_content(film_3.name)
        expect(page).to have_no_content(film_3.rt_rank)
        expect(page).to have_no_content(film_4.name)
        expect(page).to have_no_content(film_4.rt_rank)
      end
    end
  end
end
