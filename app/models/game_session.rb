class GameSession < ApplicationRecord
  belongs_to :game
  has_many :users
  has_many :messages
end
