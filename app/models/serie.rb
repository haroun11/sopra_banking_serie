class Serie < ApplicationRecord
  include PgSearch::Model

  has_many :reviews
  has_many :shoot_locations
  has_many :actors, through: :shoot_locations

  pg_search_scope :search,
                  associated_against: {
                    actors: [:name]
                  }

  def self.avg_score(serie_id)
    reviews = Review.where(serie_id: serie_id)
    reviews.average(:stars).round(2).to_f
  end
end
