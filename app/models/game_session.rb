class GameSession < ApplicationRecord
  belongs_to :game_id
  has_many :users
  has_many :messages
end
