require 'rails_helper'

RSpec.describe Gallery, type: :model do
  it {should have_many :pieces }
end
