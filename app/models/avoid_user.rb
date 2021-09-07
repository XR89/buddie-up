class AvoidUser < ApplicationRecord
    belongs_to :user
    belongs_to :avoid_user, class_name: "User"
    validates :user_id, uniqueness: { scope: :avoid_user_id }
end
