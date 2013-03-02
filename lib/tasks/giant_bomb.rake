
namespace :giant_bomb do
  desc "TODO"
  task :update_games => :environment do
    puts "Updating games from Giant Bomb"


    @platforms = Platform.all

    @platforms.each do |platform|
      puts "PLATFORM: #{ platform.name }"

      offset = 0
      if platform.giantbomb_id?
        while offset < 1500
          puts "Offset #{offset}"
          response = HTTParty.get("http://www.giantbomb.com/api/games/?api_key=#{ENV['GIANTBOMB_KEY']}&sort=date_added:desc&filter=platforms:#{platform.giantbomb_id}&format=json&limit=100&offset=#{offset}")
          # puts response.body, response.code, response.message, response.headers.inspect

          response['results'].each do |item|
            puts item['name']

            game = Game.find_or_create_by_giantbomb_id(item['id'])

            game.name = item['name']

            game.deck = item['deck']
            game.description = item['description']

            game.date_added = item['date_added']
            if item['original_release_date']
              game.original_release_date = item['original_release_date']
            end

            if item['image']
              game.icon_url   = item['image']['icon_url']
              game.medium_url = item['image']['medium_url']
              game.screen_url = item['image']['screen_url']

              game.small_url  = item['image']['small_url']
              game.super_url  = item['image']['super_url']
              game.thumb_url  = item['image']['thumb_url']
              game.tiny_url   = item['image']['tiny_url']
            end

            game.save
          end

          offset = offset + 100
        end
      end
    end

  end

  task :import_game => :environment do |t, args|
    puts "#{ENV['GAME_ID']}"

    response = HTTParty.get("http://www.giantbomb.com/api/games/?api_key=058008a8afcd045e6b54935e58ca9325e14f7958&format=json&filter=id:#{ENV['GAME_ID']}")
    response['results'].each do |item|
      puts item['name']

      game = Game.find_or_create_by_giantbomb_id(item['id'])

      game.name = item['name']

      game.deck = item['deck']
      game.description = item['description']

      game.date_added = item['date_added']
      if item['original_release_date']
        game.original_release_date = item['original_release_date']
      end

      game.icon_url   = item['icon_url']
      game.medium_url = item['medium_url']
      game.screen_url = item['screen_url']

      game.small_url  = item['small_url']
      game.super_url  = item['super_url']
      game.thumb_url  = item['thumb_url']
      game.tiny_url   = item['tiny_url']

      game.save
    end
  end

end
