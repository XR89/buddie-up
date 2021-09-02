require 'json'
require 'nokogiri'
require 'open-uri'

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
    games = {}
    p "Seeding Top 100 Steam games..."
    top_100_games.each do |element|
      appid = element[1]["appid"]
      games[appid] = {
          title:element[1]["name"],
          image_url: "https://cdn.cloudflare.steamstatic.com/steam/apps/#{appid}/header.jpg",
          developer: element[1]["developer"],
          description: game_description(appid),
          genre: game_genres(appid),
          background_image_url: "https://cdn.akamai.steamstatic.com/steam/apps/#{appid}/page_bg_generated_v6b.jpg"
      }
    end
    File.write('db/games.json', JSON.dump(games))
end

top_100_games