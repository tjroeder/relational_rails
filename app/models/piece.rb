class Piece < ApplicationRecord
  belongs_to :gallery

  def self.original_only
    where(original: true)
  end

 def self.created_after(filter_year)
   where("year > ?", filter_year)
 end
end
