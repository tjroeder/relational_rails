require 'rails_helper'

RSpec.describe Director, type: :model do
  let!(:director_1) { Director.create!(name: 'Wes Anderson', imdb_rank: 20, tv_credit: false) }
  let!(:director_2) { Director.create!(name: 'Steven Spielberg', imdb_rank: 1, tv_credit: true) }
  let!(:director_3) { Director.create!(name: 'George Lucas', imdb_rank: 25, tv_credit: true) }

  let!(:film_1) { director_1.films.create!(name: 'Bottle Rocket', rt_rank: 85, nominated: false) }
  let!(:film_2) { director_1.films.create!(name: 'Life Aquatic', rt_rank: 56, nominated: false) }
  let!(:film_3) { director_3.films.create!(name: 'Star Wars: A New Hope', rt_rank: 92, nominated: true) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:imdb_rank) }
    # it { should validate_presence_of(:tv_credit) }
  end

  describe 'relationships' do
    it { should have_many :films }
  end

  describe 'class methods' do
    describe 'self.desc_order_by_created' do
      it 'returns a list of directors order by latest creation' do
        sleep(1)
        director_4 = Director.create!(name: 'Sophia Coppola', imdb_rank: 13, tv_credit: true)

        expected = [director_1, director_2, director_3, director_4]
        expect(Director.all).to eq(expected)

        expected = [director_4, director_3, director_2, director_1]
        expect(Director.desc_order_by_created).to eq(expected)
      end
    end
  end

  describe 'instance methods' do
    describe 'total_films' do
      it 'returns a count of the all of the directors films' do
        expect(director_1.total_films).to eq(2)
        expect(director_2.total_films).to eq(0)
        expect(director_3.total_films).to eq(1)
      end
    end
  end
end