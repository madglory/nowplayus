FactoryGirl.define do
  factory :participant do
    association :user, factory: :user
    association :event, factory: :event
  end
end