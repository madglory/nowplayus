FactoryGirl.define do
  factory :user do |f|
    f.sequence(:username) { |n| "USR_#{n}" }
    f.time_zone 'Tijuana'
    f.avatar_url 'http://www.achievementstats.com/images/icons/unlocked/6173.jpg'
  end
end