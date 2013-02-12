# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Make some Users
u1 = User.new username: 'claptrap'
u1.time_zone = 'Tijuana'
u1.avatar_url = 'http://www.achievementstats.com/images/icons/unlocked/6173.jpg'
u1.save

u2 = User.new username: 'master_chief'
u2.time_zone = 'EST'
u2.avatar_url = 'http://aux.iconpedia.net/uploads/2008543944.png'
u2.save

# Make some Events
e1 = Event.new title: 'Call of Duty: Black Ops 2', platform: 'XBOX', starts_at_raw: 'Thursday 5pm', duration_raw: '2hr'
e1.user = u1
e1.save
e2 = Event.new title: 'League of Legends', platform: 'PC', starts_at_raw: 'Friday 10:30pm', duration_raw: '4 hours'
e2.user = u2
e2.save

# Make some Players
Player.create! user_id: u2.id, event_id: e1.id
Player.create! user_id: u1.id, event_id: e2.id