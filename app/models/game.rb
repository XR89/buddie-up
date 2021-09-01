class Game < ApplicationRecord
  validates :title, :genre, :developer, :image_url, presence: true

  include PgSearch::Model
  pg_search_scope :search_game_by_title,
    against: [ :title ],
    using: {
      tsearch: { prefix: true }
    }
end
