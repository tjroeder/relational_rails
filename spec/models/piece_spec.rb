require 'rails_helper'

RSpec.describe Piece, type: :model do
  let(:gallery_1) {Gallery.create!(name: "Art 4 Us", non_profit: true, entry_cost: 4.75, created_at: '2021-12-03 20:42:56 UTC')}
  let(:piece_1) {Piece.create!(name: "Starry Night", artist: "Vincent Van Gogh", year: 1889, original: true, gallery_id: gallery_1.id)}
  let(:piece_2) {Piece.create!(name: "Self Portrait", artist: "Vincent Van Gogh", year: 1889, original: true, gallery_id: gallery_1.id)}
  let(:piece_3) {Piece.create!(name: "Girl with the Pearl Earring", artist: "Johannes Vermeer", year: 1665, original: false, gallery_id: gallery_1.id)}

  it {should belong_to :gallery}

  describe '#original_only' do
    it 'only displays pieces with tru value for :original' do
      expect(Piece.original_only).to eq([piece_1, piece_2])
    end
  end
end
