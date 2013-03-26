FactoryGirl.define do

  factory :comment do |f|
    f.association :user, factory: :user
    f.association :commentable, factory: :event
    f.sequence(:comment) { |n| "Shit happens...#{n}" }
  end
end
