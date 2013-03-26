# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    user nil
    actionable_type "MyString"
    actionable_id 1
    viewed_at "2013-03-24 14:23:13"
  end
end
