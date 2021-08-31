class Game < ApplicationRecord
  validates :title, :genre, :description, :developer, :image_url, presence: true
end
