require 'spec_helper'

describe ParticipantObserver do
  subject { ParticipantObserver.instance }
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:participant) { create(:participant, user: user, event: event) }

  before(:each) do
    # so we only test this observer... 
    ActiveRecord::Base.observers.enable :participant_observer
  end

  context "after_create" do
    describe "#create_notification_subscription" do
      it "should create a NotificationSubscription for the user who joined" do
        expect { subject.after_create(participant) }.to change(NotificationSubscription, :count).by(1)

        NotificationSubscription.first.user.should eq(user)
      end
    end

    describe "#create_notifications_for_subscribers" do
      let(:subscribed_user) { create(:user) }
      before(:each) do
        subscribed_user.notification_subscriptions.create subscribable_type: 'Event', subscribable_id: event.id
      end
      it "should create a Notification all subscribed users except the one who joined" do
        expect { subject.after_create(participant) }.to change(Notification, :count).by(1)

        Notification.first.user.should eq(subscribed_user)
      end
    end
  end
end
