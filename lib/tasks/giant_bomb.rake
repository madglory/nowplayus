
namespace :giant_bomb do
  desc "TODO"
  task :update_games => :environment do
    puts "Updating games from Giant Bomb"

    if ['production','staging'].include?(Rails.env)
      @giantbomb_key = ENV['GIANTBOMB_KEY']
    else
      @giantbomb_key = '058008a8afcd045e6b54935e58ca9325e14f7958'
    end

    

    Game::PLATFORMS.each do |platform_name,platform_id|
      puts "PLATFORM: #{ platform_name }"

      offset = 0

      while offset < 100
        puts "Offset #{offset}"
        response = HTTParty.get("http://www.giantbomb.com/api/games/?api_key=#{@giantbomb_key}&sort=date_last_updated:desc&filter=platforms:#{platform_id}&format=json&limit=100&offset=#{offset}")
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

  desc "Import a specific game; Set GAME_ID=XXXXX"
  task :import_game => :environment do |t, args|
    puts "#{ENV['GAME_ID']}"

    if ['production','staging'].include?(Rails.env)
      @giantbomb_key = ENV['GIANTBOMB_KEY']
    else
      @giantbomb_key = '058008a8afcd045e6b54935e58ca9325e14f7958'
    end

    response = HTTParty.get("http://www.giantbomb.com/api/games/?api_key=#{@giantbomb_key}&format=json&filter=id:#{ENV['GAME_ID']}")
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

      game.icon_url   = item['image']['icon_url']
      game.medium_url = item['image']['medium_url']
      game.screen_url = item['image']['screen_url']

      game.small_url  = item['image']['small_url']
      game.super_url  = item['image']['super_url']
      game.thumb_url  = item['image']['thumb_url']
      game.tiny_url   = item['image']['tiny_url']

      game.save
    end
  end

end
