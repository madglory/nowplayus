FactoryGirl.define do
  factory :platform_account do |f|
    f.association :user, factory: :user
    f.association :platform, factory: :event
    f.sequence(:username) { |n| "USER_#{n}" }
  end
end