FactoryGirl.define do
  factory :platform do |f|
    f.sequence(:name) { |n| "CONSOLE #{n}" }
  end
end