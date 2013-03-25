# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification_setting do
    user nil
    comment_via_email false
    comment_via_direct_message false
    participant_via_email false
    participant_via_direct_message false
  end
end
