require 'json'
require 'open-uri'
require 'nokogiri'

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

def game_description(appid)
  url = "https://store.steampowered.com/app/#{appid}/"
  html_file = URI.open(url).read
  html_doc = Nokogiri::HTML(html_file)
  html_doc.search('.game_description_snippet').each do |element|
    return element.text.strip
  end
end

def game_genres(appid)
  game_serialized = URI.open("https://steamspy.com/api.php?request=appdetails&appid=#{appid}").read
  game = JSON.parse(game_serialized)
  game["genre"].split
end

def top_100_games
  top_100_steam_games_url = "https://steamspy.com/api.php?request=top100in2weeks"
  top_100_serialized = URI.open(top_100_steam_games_url).read
  top_100_games = JSON.parse(top_100_serialized)
  p "Seeding Top 100 Steam games..."
  top_100_games.each do |element|
    appid = element[1]["appid"]
    game = Game.new(title: element[1]["name"],
                image_url: "https://cdn.cloudflare.steamstatic.com/steam/apps/#{appid}/header.jpg",
                developer: element[1]["developer"],
                description: game_description(appid),
                genre: game_genres(appid))
    p "#{Game.count}/100 - Created Game: #{element[1]["name"]}" if game.save!
  end
end

def first_10_users
  p "Seeding first 10 users..."
  User.new(
    email: 'test@test.com',
    username: 'tester1',
    password: 'password',
    region: 'Antarctica',
    dob: Faker::Date.between(from: '1970-01-01', to: '2000-01-01').strftime('%Y-%m-%d'),
    gender: "Prefer not to say",
    language: LANGUAGES.sample
  )
  p "#{User.count + 1}/10 - Created test user"

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

# top_100_games
first_10_users
