class FavouriteUser < ApplicationRecord
    belongs_to :user
    belongs_to :favourite_user, class_name: "User"
end
