class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, :region, :dob, :gender, :language, presence: true
  validates :username, format: { with: /\A[A-Za-z0-9\-_.]+\z/i,
                                 message: "Please use only letters from the latin alphabet,
                                           numbers, and punctuation: -_." },
                       length: { minimum: 3, maximum: 255 },
                       uniqueness: true
  validates :region, inclusion: { in: @regions,
                                  message: "%<value> is not a valid region" }
  # validation for languages?
  validate :validate_age
  validate :gender, inclusion: { in: ["Male", "Female", "Non-binary", "Prefer not to say"] }
  # validation for user status (0 - offline, 1 - online) may require sessions?

  has_many :user_ratings
  has_one_attached :photo

  private

  def validate_age
    if dob.present? && dob > 18.years.ago.to_d
      errors.add(:dob, 'You must be at least 18 years old.')
    end
  end

  @regions = [
    "Europe",
    "North America",
    "South America",
    "Africa",
    "Middle East",
    "East Asia",
    "Southeast Asia",
    "Australia & Pacific",
    "Antarctica"
  ]

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
