require 'rails_helper'

RSpec.describe Film, type: :model do
  let!(:director_1) { Director.create!(name: 'Wes Anderson', imdb_rank: 20, tv_credit: false) }
  let!(:director_2) { Director.create!(name: 'Steven Spielberg', imdb_rank: 1, tv_credit: true) }
  let!(:director_3) { Director.create!(name: 'George Lucas', imdb_rank: 25, tv_credit: true) }

  let!(:film_1) { director_1.films.create!(name: 'Bottle Rocket', rt_rank: 85, nominated: false) }
  let!(:film_2) { director_1.films.create!(name: 'Life Aquatic', rt_rank: 56, nominated: false) }
  let!(:film_3) { director_3.films.create!(name: 'Star Wars: A New Hope', rt_rank: 92, nominated: true) }
  let!(:film_4) { director_3.films.create!(name: 'Star Wars: Empire Strikes Back', rt_rank: 1, nominated: true) }


  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:rt_rank) }
  end

  describe 'relationships' do
    it { should belong_to :director}
  end

  describe 'class methods' do
    describe '::nominated_only' do
      it 'can return all records that are nominated' do
        expect(Film.nominated_only).to eq([film_3, film_4])
      end
    end
  end
end