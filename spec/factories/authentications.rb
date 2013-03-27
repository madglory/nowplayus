# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authentication do
    association :user, factory: :user
    sequence(:uid) { |n| "uid-#{n}" }
  end
end
