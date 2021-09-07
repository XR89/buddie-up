class UserRating < ApplicationRecord
  belongs_to :user, dependent: :destroy
  validates_inclusion_of :rating, :in => 1..10
end
