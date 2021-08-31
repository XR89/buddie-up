class UserRating < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
