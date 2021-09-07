class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :game_session
  belongs_to :inviter, class_name: "User"
end
