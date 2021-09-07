class FavouriteUser < ApplicationRecord
  belongs_to :user
  belongs_to :favourite_user, class_name: "User"
  validates :user_id, uniqueness: { scope: :favourite_user_id }
end
