class Game < ApplicationRecord
  validates :title, :genre, :developer, :image_url, presence: true
end
