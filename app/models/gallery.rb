class Gallery < ApplicationRecord
  has_many :pieces

  validates_presence_of :name, :entry_cost

  def total_pieces
    pieces.size
  end

  def self.created_at_order_desc
    Gallery.order(created_at: :desc)
  end

  def self.order_by_piece_count
    Gallery.left_joins(:pieces).group(:id).order('COUNT(pieces.id)DESC')
  end
end
