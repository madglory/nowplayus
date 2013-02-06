namespace :db do
  desc "Erase and fill the database with test data"

  task :populate => :environment do
    puts "Populating..."

    Authentication.delete_all
    User.delete_all
    Event.delete_all
    Player.delete_all



    User.populate 20 do |user|
      user.username = Forgery(:internet).user_name

      Event.populate 2..5 do |event|
        event.user_id = user.id
        event.title =  ["Borderlands 2", "League of Legends", "Halo 4", "Call of Duty"].sample
        event.platform =  ["XBOX", "PS3", "PC", "Steam"].sample
        event.description = Faker::Lorem.sentence(20)

        event.starts_at = Time.now+Random.rand(10000..20000)
        event.duration = Random.rand(5000..7200)
        event.slots = Random.rand(1..8)
        event.slots_filled  = 0
        event.bench_count  = 0
      end
    end

  end


end