# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification_subscription do
    association :user, factory: :user
    association :subscribable, factory: :event
  end
end
