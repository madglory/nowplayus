GIANTBOMB_KEY = ['production','staging'].include?(Rails.env) ? ENV['GIANTBOMB_KEY'] : '058008a8afcd045e6b54935e58ca9325e14f7958'

namespace :giant_bomb do
  desc "TODO"
  task :update_games => :environment do
    puts "Updating games from Giant Bomb" 

    Game::PLATFORMS.each do |platform_name,platform_id|
      puts "PLATFORM: #{ platform_name }"

      10.times do |pass|
        offset = pass * 100
        puts "Fetching records #{offset + 1} - #{offset + 100}"

        response = HTTParty.get("http://www.giantbomb.com/api/games/?api_key=#{GIANTBOMB_KEY}&sort=date_last_updated:desc&filter=platforms:#{platform_id}&format=json&limit=100&offset=#{offset}")

        response['results'].each do |item|
          puts item['name']
          data = GiantBombData.new item
          game = Game.find_or_create_by_giantbomb_id(item['id'])
          game.update_attributes data.to_hash
        end
      end
    end
  end

  desc "Import a specific game; Set GAME_ID=XXXXX"
  task :import_game => :environment do |t, args|
    puts "#{ENV['GAME_ID']}"    

    response = HTTParty.get("http://www.giantbomb.com/api/games/?api_key=#{GIANTBOMB_KEY}&format=json&filter=id:#{ENV['GAME_ID']}")
    response['results'].each do |item|
      puts item['name']

      data = GiantBombData.new item
      game = Game.find_or_create_by_giantbomb_id(item['id'])
      game.update_attributes data.to_hash
    end
  end
end

class GiantBombData
  attr_accessor :name, :deck, :description, :date_added, :original_release_date, :icon_url, :medium_url, :screen_url, :small_url, :super_url, :thumb_url, :tiny_url

  def initialize(item)
    @name = item['name']
    @deck = item['deck']
    @description = item['description']
    @date_added = item['date_added']
    @original_release_date = item['original_release_date']
    @icon_url   = item['image'] ? item['image']['icon_url'] : ''
    @medium_url = item['image'] ? item['image']['medium_url'] : ''
    @screen_url = item['image'] ? item['image']['screen_url'] : ''
    @small_url  = item['image'] ? item['image']['small_url'] : ''
    @super_url  = item['image'] ? item['image']['super_url'] : ''
    @thumb_url  = item['image'] ? item['image']['thumb_url'] : ''
    @tiny_url   = item['image'] ? item['image']['tiny_url'] : ''
  end

  def to_hash
    {
      name: name,
      deck: deck,
      description: description,
      date_added: date_added,
      original_release_date: original_release_date,
      icon_url: icon_url,
      medium_url: medium_url,
      screen_url: screen_url,
      small_url: small_url,
      super_url: super_url,
      thumb_url: thumb_url,
      tiny_url: tiny_url
    }
  end
end