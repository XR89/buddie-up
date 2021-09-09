class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :chat
  belongs_to :inviter, class_name: "User"
end
