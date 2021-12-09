require 'rails_helper'

RSpec.describe '/director/index.html.erb', type: :feature do
  let!(:director_1) { Director.create!(name: 'Wes Anderson', imdb_rank: 20, tv_credit: false) }
  let!(:director_2) { Director.create!(name: 'Steven Spielberg', imdb_rank: 1, tv_credit: true) }
  let!(:director_3) { Director.create!(name: 'George Lucas', imdb_rank: 25, tv_credit: true) }

  let!(:film_1) { director_1.films.create!(name: 'Bottle Rocket', rt_rank: 85, nominated: false) }
  let!(:film_2) { director_1.films.create!(name: 'Life Aquatic', rt_rank: 56, nominated: false) }
  let!(:film_3) { director_3.films.create!(name: 'Star Wars: A New Hope', rt_rank: 92, nominated: true) }


  describe 'as a user' do
    describe 'when I visit the directors index' do
      it 'should visit the page at /directors' do
        visit '/directors'

        expect(page).to have_current_path('/directors')
      end

      it 'displays all the directors names' do
        visit '/directors'

        expect(page).to have_content(director_1.name)
        expect(page).to have_content(director_2.name)
        expect(page).to have_content(director_3.name)
      end

      it 'displays all directors names and the created time of the entry' do
        visit '/directors'
        
        expect(page).to have_content("Created at: #{director_1.created_at}")
      end

      it 'displays all directors names ordered by latest created descending' do
        sleep(1)
        director_4 = Director.create!(name: 'Sophia Coppola', imdb_rank: 13, tv_credit: true)
        visit '/directors'

        expect(director_4.name).to appear_before(director_3.name)
        expect(director_3.name).to appear_before(director_2.name)
        expect(director_2.name).to appear_before(director_1.name)
      end
      
      it 'displays a link called Films Index' do
        visit '/directors'
        
        expect(page).to have_link('Films Index', href: '/films')
      end
      
      it 'displays a link called Directors Index' do
        visit '/directors'
        
        expect(page).to have_link('Directors Index', href: '/directors')
      end
      
      it 'displays a link called New Director' do
        visit '/directors'
        
        expect(page).to have_link('New Director', href: '/directors/new')
      end
      
      it 'displays a link to individual Directors' do
        visit '/directors'
        
        expect(page).to have_link("#{director_1.name}", href: "/directors/#{director_1.id}")
      end
      
      it 'displays a link called Edit Director' do
        visit '/directors'
        
        expect(page).to have_link('Edit Director', href: "/directors/#{director_1.id}/edit")
      end
      
      it 'displays a button to sort directors by number of films' do
        visit '/directors'
        
        expect(page).to have_button('Sort')
      end
      
      it 'displays all directors names ordered by total films' do
        visit '/directors'
        click_button 'Sort'
        
        expect(director_1.name).to appear_before(director_3.name)
        expect(director_1.name).to appear_before(director_2.name)
        expect(director_3.name).to appear_before(director_2.name)
      end
      
      it 'displays film count next to directors name' do
        visit '/directors'
        click_button 'Sort'
                
        expect("Film Count: #{director_1.total_films}").to appear_before("Film Count: #{director_3.total_films}")
        expect("Film Count: #{director_1.total_films}").to appear_before("Film Count: #{director_2.total_films}")
        expect("Film Count: #{director_3.total_films}").to appear_before("Film Count: #{director_2.total_films}")
      end
    end

    describe 'can click links' do
      it 'redirect the user to the films index' do
        visit '/directors'
        click_link 'Films Index'
        
        expect(page).to have_current_path('/films')
      end

      it 'redirect the user to the directors index' do
        visit '/directors'
        click_link 'Directors Index'
        
        expect(page).to have_current_path('/directors')
      end

      it 'redirect the user to the new director form' do
        visit '/directors'
        click_link 'New Director'
        
        expect(page).to have_current_path('/directors/new')
      end

      it 'redirect the user the individual director page' do
        visit '/directors'
        click_link "#{director_1.name}"

        expect(page).to have_current_path("/directors/#{director_1.id}")
      end

      it 'redirect the user to Edit Director form' do
        visit '/directors'
        page.find(:css, "#edit-#{director_1.id}").click_on
        
        expect(page).to have_current_path("/directors/#{director_1.id}/edit")
      end

      it 'redirects the user to the sorted directors index by film count' do
        visit '/directors'
        click_button 'Sort'

        expect(page).to have_current_path("/directors?utf8=%E2%9C%93&commit=Sort")
      end
    end
  end
end