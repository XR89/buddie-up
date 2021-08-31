class Session < ApplicationRecord
  belongs_to :game_id
  has_many :users
end
