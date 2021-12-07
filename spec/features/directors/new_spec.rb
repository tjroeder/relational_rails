require 'rails_helper' 

RSpec.describe '/directors/new.html.erb' do
  describe 'as a user' do
    describe 'when I visit the page at /directors/new' do
      it 'has input forms for creating a new director' do
        visit '/directors'
        click_on 'Add New Director'

        expect(page).to have_field('Director Full Name:')
        expect(page).to have_field('IMDB Ranking:')
        expect(page).to have_field('TV Credit:')
      end
    end

    describe 'when they fill in a input forms' do
      it 'creates a new Director and returns to /directors' do
        visit '/directors'
        click_on 'Add New Director'

        fill_in :name, with: 'Taika Waititi'
        fill_in :imdb_rank, with: '13'
        select 'Yes', from: :tv_credit
        click_on 'Create Director'

        expect(page).to have_current_path('/directors')
        expect(page).to have_content('Taika Waititi')
      end
    end
  end
end