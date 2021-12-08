class Director < ApplicationRecord
  has_many :films, dependent: :destroy
  
  validates_presence_of :name, :imdb_rank
  validates :tv_credit, inclusion: [true, false]

  def self.desc_order_by_created
    order(created_at: :desc)
  end

  def total_films
    films.size
  end

  def sort_alphabetically(type)
    films.order(name: type)
  end

  def filter_film_rt_rank(number)
    films.where("rt_rank > ?", number)
  end
end