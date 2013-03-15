# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Remove all previous seeds.
Platform.all.each { |p| p.destroy }
User.all.each { |p| p.destroy }
PlatformAccount.all.each { |p| p.destroy }
Event.all.each { |p| p.destroy }
Participant.all.each { |p| p.destroy }

# Make some Platforms
p1 = Platform.create! name: 'XBOX', giantbomb_id: 20
p2 = Platform.create! name: 'PS3', giantbomb_id: 88

# Make some Platforms
c1 = Clan.create! name: 'El1T3'
c2 = Clan.create! name: 'FOO'

# Make some Users
u1 = User.new username: 'claptrap'
u1.time_zone = 'Tijuana'
u1.avatar_url = 'http://www.achievementstats.com/images/icons/unlocked/6173.jpg'
u1.clans << c1
u1.save!

u2 = User.new username: 'master_chief'
u2.time_zone = 'EST'
u2.avatar_url = 'http://images2.wikia.nocookie.net/__cb20081207013819/halo/images/8/85/1228613897_Master_chief_halo.gif'
u2.clans << c2
u2.save!

u3 = User.new username: 'kratos'
u3.time_zone = 'EST'
u3.avatar_url = 'http://mmii.info/icons/Koole321/games_chibiKratos.gif'
u3.save!

# Assign PlatformAccounts to Users
pa1 = PlatformAccount.new username: 'claptrap_is_god'
pa1.user = u1
pa1.platform_id = Platform.first.id
pa1.save!

pa2 = PlatformAccount.new username: 'masterchief'
pa2.user = u2
pa2.platform = p1
pa2.save!

pa1 = PlatformAccount.new username: 'claptrap_hates_minions'
pa1.user = u1
pa1.platform = p2
pa1.save!

pa3 = PlatformAccount.new username: 'kratos'
pa3.user = u3
pa3.platform = p1
pa3.save!

g1 = Game.new name: 'Derp\'s Quest'
g1.save
g2 = Game.new name: 'Foo\'s Mission'
g2.save

# Make some Events
e1 = Event.new game_id: Game.first.id, platform_id: p1.id, starts_at_raw: 'Thursday 5pm', duration_raw: '2 hours', total_players: 3
e1.user = u1
e1.game = g1
e1.save!
e2 = Event.new game_id: Game.last.id, platform_id: p2.id, starts_at_raw: 'Friday 10:30pm', duration_raw: '4 hours', total_players: 3
e2.user = u2
e2.game = g2
e2.save!

# Make some Participants
Participant.create! user_id: u2.id, event_id: e1.id, is_host: true
Participant.create! user_id: u3.id, event_id: e1.id, is_host: false
Participant.create! user_id: u1.id, event_id: e2.id, is_host: true
