class Piece < ApplicationRecord
  belongs_to :gallery

  def self.original_only
    where(original: true)
  end
end
