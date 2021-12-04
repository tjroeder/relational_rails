require 'rails_helper'

RSpec.describe '/director/index.html.erb', type: :feature do
  let!(:director_1) { Director.create!(name: 'Wes Anderson', imdb_rank: 20, tv_credit: false) }
  let!(:director_2) { Director.create!(name: 'Steven Spielberg', imdb_rank: 1, tv_credit: true) }
  let!(:director_3) { Director.create!(name: 'George Lucas', imdb_rank: 25, tv_credit: true) }

  describe 'as a user' do
    describe 'when I visit the directors index' do
      it 'should visit the page at /directors' do
        visit '/directors'

        expect(page).to have_current_path("/directors")
      end

      it 'displays all the directors names' do
        visit '/directors'

        expect(page).to have_content(director_1.name)
        expect(page).to have_content(director_2.name)
      end

      it 'displays all directors names and the created time of the entry' do
        visit '/directors'

        expected_1 = "#{director_1.name} - Created at: #{director_1.created_at}"
        expected_2 = "#{director_2.name} - Created at: #{director_2.created_at}"
        expected_3 = "#{director_3.name} - Created at: #{director_3.created_at}"
        expect(page).to have_content(expected_1)
        expect(page).to have_content(expected_2)
        expect(page).to have_content(expected_3)
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

        expect(page).to have_link("Films Index", :href=>"/films")
      end

      it 'displays a link called Directors Index' do
        visit '/directors'

        expect(page).to have_link("Directors Index", :href=>"/directors")
      end
      
      it 'displays a link called New Director' do
        visit '/directors'

        expect(page).to have_link("New Director", :href=>"/directors/new")
      end
    end

    describe 'can click links' do
      it 'redirect the user to the films index' do
        visit '/directors'
        click_link 'Films Index'
        
        expect(page).to have_current_path("/films")
      end

      it 'redirect the user to the directors index' do
        visit '/directors'
        click_link 'Directors Index'
        
        expect(page).to have_current_path("/directors")
      end

      it 'redirect the user to the new director form' do
        visit '/directors'
        click_link 'New Director'
        
        expect(page).to have_current_path("/directors/new")
      end
    end
  end
end