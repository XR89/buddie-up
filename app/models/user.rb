class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, :region, :dob, :gender, presence: true
  validates :username, format: { with: /\A[A-Za-z0-9\-_.£$€@*]+\z/i,
                                 message: "Please use only letters from the latin alphabet,
                                           numbers, and punctuation: -_.£$€@*" },
                       length: { minimum: 3, maximum: 255 },
                       uniqueness: true
  validates :region, inclusion: { in: ["Europe",
                                       "North America",
                                       "South America",
                                       "Africa",
                                       "Middle East",
                                       "East Asia",
                                       "Southeast Asia",
                                       "Australia & Pacific",
                                       "Antarctica"],
                                  message: "%<value> is not a valid region" }
  # validation for languages?
  validate :validate_age
  validates :gender, inclusion: { in: ["Male", "Female", "Other", "Prefer not to say"] }

  has_one_attached :photo
  has_many :favourite_users, foreign_key: :user_id
  has_many :avoid_users, foreign_key: :user_id
  has_many :user_ratings, foreign_key: :user_id
  has_many :invitations
  # has_many :invitations, foreign_key: :inviter_id
  has_many :favourite_games

  private

  def validate_age
    if dob.present? && dob.strftime('%Y%m%d').to_i > 18.years.ago.strftime('%Y%m%d').to_i
      errors.add(:dob, 'You must be at least 18 years old.')
    end
  end

  @languages = %w[
    English
    Czech
    Danish
    Dutch
    Finnish
    French
    German
    Hungarian
    Italian
    Japanese
    Korean
    Norwegian
    Polish
    Portuguese
    Romanian
    Russian
    Simplified Chinese
    Spanish
    Swedish
    Thai
    Traditional Chinese
    Turkish
    Bulgarian
    Ukrainian
    Greek
    Vietnamese
    Arabic
    Hindi
    Other
  ]
end
