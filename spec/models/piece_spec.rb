require 'rails_helper'

RSpec.describe Piece, type: :model do
  it {should belong_to :gallery}
end
