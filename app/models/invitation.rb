class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :game_session
end
