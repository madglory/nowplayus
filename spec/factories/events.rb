FactoryGirl.define do

  factory :event do |f|
    f.sequence(:title) { |n| "GAME #{n}" }
    f.association :user, factory: :user
    f.association :platform, factory: :platform
    f.starts_at '2014-02-15 22:30:00 -0500'
    f.duration 14400
    f.slots 1
  end
end