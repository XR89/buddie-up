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
  p "Seeding first 20 users..."
  test_user = User.new(
    email: 'louis@test.com',
    username: 'kinglouisxv',
    password: 'password',
    region: 'Europe',
    dob: Faker::Date.between(from: '1970-01-01', to: '2000-01-01').strftime('%Y-%m-%d'),
    gender: "Prefer not to say",
    language: LANGUAGES.sample
  )
  p "#{User.count}/20 - Created Louis's account" if test_user.save!

  test_user = User.new(
    email: 'xander@test.com',
    username: 'rumpeltiltskin',
    password: 'password',
    region: 'Antarctica',
    dob: Faker::Date.between(from: '1970-01-01', to: '2000-01-01').strftime('%Y-%m-%d'),
    gender: "Prefer not to say",
    language: LANGUAGES.sample
  )
  p "#{User.count}/20 - Created Xander's account" if test_user.save!

  test_user = User.new(
    email: 'drew@test.com',
    username: 'king$layer',
    password: 'password',
    region: 'North America',
    dob: Faker::Date.between(from: '1970-01-01', to: '2000-01-01').strftime('%Y-%m-%d'),
    gender: "Prefer not to say",
    language: LANGUAGES.sample
  )
  p "#{User.count}/20 - Created Drew's account" if test_user.save!

  test_user = User.new(
    email: 'jacob@test.com',
    username: 'jdizzle',
    password: 'password',
    region: 'Africa',
    dob: Faker::Date.between(from: '1970-01-01', to: '2000-01-01').strftime('%Y-%m-%d'),
    gender: "Prefer not to say",
    language: LANGUAGES.sample
  )
  p "#{User.count}/20 - Created Jacob's account" if test_user.save!

  user = 'user1@test.com'
  counter = 1
  16.times do
    user = User.new(
      email: "user#{counter}@test.com",
      username: Faker::Internet.username(specifier: 3..16),
      password: 'password',
      region: REGIONS.sample,
      dob: Faker::Date.between(from: '1970-01-01', to: '2000-01-01').strftime('%Y-%m-%d'),
      gender: ['Male', 'Female', 'Other', 'Prefer not to say'].sample,
      language: LANGUAGES.sample
    )
    # Does not include handles, favourite games, favourite/avoided users, online status
    p "#{User.count}/20 - Created User: #{user.username} from #{user.region}" if user.save!
    counter += 1
  end
end

def two_chat_sessions
  p "Creating two game sessions..."
  2.times do
    game_session = GameSession.new(
      ongoing: true,
      status: 'fiiine',
      game_id: 1
    )
    p "Created a game session" if game_session.save!
  end
end

def seed_100_games
  serialized_games = File.read('db/games.json')
  top_100_games = JSON.parse(serialized_games)
  p "Seeding Top 100 games"
  top_100_games.each do |game|
    Game.create!(
      title: game[1]["title"],
      developer: game[1]["developer"],
      description: game[1]["description"],
      genre: game[1]["genre"],
      image_url: game[1]["image_url"],
      background_image_url: game[1]["background_image_url"]
    )
    p "Seeded: #{game[1]["title"]}"
  end
end

seed_100_games
first_10_users
two_chat_sessions
