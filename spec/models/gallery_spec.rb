require 'rails_helper'

RSpec.describe Gallery, type: :model do
  let(:gallery_1) {Gallery.create!(name: "Art 4 Us", non_profit: true, entry_cost: 4.75, created_at: '2021-12-03 20:42:56 UTC')}

  let(:gallery_2) {Gallery.create!(name: "Benji's Gallery", non_profit: false, entry_cost: 10, created_at: '2021-12-03 20:43:52 UTC')}

  describe 'relationships' do
    it { should have_many :pieces }
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:entry_cost)}
  end

  describe 'instance methods' do
    it 'counts total number of associated pieces' do
      piece_1 = gallery_1.pieces.create!(name: "Starry Night", artist: "Vincent Van Gogh", year: 1889, original: false)
      piece_2 = gallery_1.pieces.create!(name: "Self Portrait", artist: "Vincent Van Gogh", year: 1889, original: true)
      piece_3 = gallery_1.pieces.create!(name: "Girl with the Pearl Earring", artist: "Johannes Vermeer", year: 1665, original: false)

      expect(gallery_1.total_pieces).to eq(3)
    end
  end

  describe 'class methods' do
    it 'orders galleries in descending order of create date' do
      expect(Gallery.created_at_order_desc).to eq([gallery_2, gallery_1])
    end

    it 'orders galleries based on number of pieces they house' do
      piece_1 = gallery_1.pieces.create!(name: "Starry Night", artist: "Vincent Van Gogh", year: 1889, original: false)
      piece_2 = gallery_2.pieces.create!(name: "Self Portrait", artist: "Vincent Van Gogh", year: 1889, original: true)
      piece_3 = gallery_2.pieces.create!(name: "Girl with the Pearl Earring", artist: "Johannes Vermeer", year: 1665, original: false)

      expect(Gallery.order_by_piece_count).to eq([gallery_2, gallery_1])
    end
  end
end
