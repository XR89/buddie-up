require 'json'

REGIONS = [
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

LANGUAGES = %w[
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
  Mandarin
  Spanish
  Swedish
  Thai
  Cantonese
  Taiwanese
  Turkish
  Bulgarian
  Ukrainian
  Greek
  Vietnamese
  Arabic
  Hindi
  Other
]


def first_10_users
  p "Seeding first 10 users..."
  test_user = User.new(
    email: 'test@test.com',
    username: 'tester1',
    password: 'password',
    region: 'Antarctica',
    dob: Faker::Date.between(from: '1970-01-01', to: '2000-01-01').strftime('%Y-%m-%d'),
    gender: "Prefer not to say",
    language: LANGUAGES.sample
  )
  p "#{User.count + 1}/10 - Created test user" if test_user.save!

  9.times do
    user = User.new(
      email: Faker::Internet.email,
      username: Faker::Internet.username(specifier: 3..16),
      password: Faker::Internet.password(min_length: 8, max_length: 32),
      region: REGIONS.sample,
      dob: Faker::Date.between(from: '1970-01-01', to: '2000-01-01').strftime('%Y-%m-%d'),
      gender: ['Male', 'Female', 'Other', 'Prefer not to say'].sample,
      language: LANGUAGES.sample
    )
    # Does not include handles, favourite games, favourite/avoided users, online status
    p "#{User.count + 1}/10 - Created User: #{user.username} from #{user.region}" if user.save!
  end
end

def seed_100_games
  serialized_games = File.read('db/games.json')
  top_100_games = JSON.parse(serialized_games)
  top_100_games.each do |game|
    p game
    p ' '
    Game.create!(
      title: game[1]["title"],
      developer: game[1]["developer"],
      description: game[1]["description"],
      genre: game[1]["genre"],
      image_url: game[1]["image_url"],
      background_image_url: game[1]["background_image_url"]
    )
  end
end



seed_100_games
first_10_users
