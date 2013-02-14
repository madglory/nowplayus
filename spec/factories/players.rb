FactoryGirl.define do
  factory :player do
    association :user, factory: :user
    association :event, factory: :event
  end
end