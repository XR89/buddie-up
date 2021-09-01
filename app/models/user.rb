class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  has_many :favourite_users, foreign_key: :user_id
  has_many :avoid_users, foreign_key: :user_id
  has_many :user_ratings, foreign_key: :user_id
  
end
