class Film < ApplicationRecord
  belongs_to :director

  validates_presence_of :name, :rt_rank
  validates :nominated, inclusion: [true, false]

  def self.nominated_only
    where(nominated: true)
  end
end