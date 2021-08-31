require 'json'
require 'open-uri'
require 'nokogiri'

top_100_steam_games_url = "https://steamspy.com/api.php?request=top100in2weeks"
top_100_serialized = URI.open(top_100_steam_games_url).read
top_100_games = JSON.parse(top_100_serialized)

top_100_games.each do |element|
  # p element[1]["name"]
  # p element[1]["developer"]
  title = element[1]["name"]
  developer = element[1]["developer"]
  game_serialized = URI.open("https://steamspy.com/api.php?request=appdetails&appid=#{element[1]["appid"]}").read
  game = JSON.parse(game_serialized)
  genre = game["genre"].split
  image_url = "https://cdn.cloudflare.steamstatic.com/steam/apps/#{element[1]["appid"]}/header.jpg"

end


# There are no API's to get descriptions by AppID, must scrape SteamDB for information
