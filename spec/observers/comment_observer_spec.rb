require 'spec_helper'

describe CommentObserver do
  subject { CommentObserver.instance }
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:comment) { create(:comment, user: user, commentable: event) }

  before(:each) do
    # so we only test this observer... 
    ActiveRecord::Base.observers.enable :comment_observer
  end

  context "after_create" do
    describe "#create_notification_subscription" do
      it "should create a NotificationSubscription for the user who commented" do
        expect { subject.after_create(comment) }.to change(NotificationSubscription, :count).by(1)

        NotificationSubscription.first.user.should eq(user)
      end
    end

    describe "#create_notifications_for_subscribers" do
      let(:subscribed_user) { create(:user) }
      before(:each) do
        subscribed_user.notification_subscriptions.create subscribable_type: 'Event', subscribable_id: event.id
      end
      it "should create a Notification for all subscribed users except the one who commented" do
        expect { subject.after_create(comment) }.to change(Notification, :count).by(1)

        Notification.first.user.should eq(subscribed_user)
      end
    end
  end
end
