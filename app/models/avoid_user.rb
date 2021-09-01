class AvoidUser < ApplicationRecord
    belongs_to :user
    belongs_to :avoid_user, class_name: "User"
end
