class Game < ApplicationRecord
  validates :title, :genre, :developer, :image_url, presence: true
  has_many :game_sessions
end
