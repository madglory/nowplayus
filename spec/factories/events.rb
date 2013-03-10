FactoryGirl.define do

  factory :event do |f|
    f.sequence(:title) { |n| "GAME #{n}" }
    f.association :user, factory: :user
    f.association :game, factory: :game
    f.association :platform, factory: :platform
    f.starts_at_raw 'tomorrow 5pm'
    f.duration_raw '1 hr'
    f.total_players 3
  end
end