FactoryGirl.define do
  factory :user do |f|
    f.time_zone 'Tijuana'
    f.sequence(:username) { |n| "USR_#{n}" }
    f.avatar_url 'http://www.achievementstats.com/images/icons/unlocked/6173.jpg'
  end
end