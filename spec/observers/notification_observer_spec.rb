require 'spec_helper'

describe NotificationObserver do
  subject { NotificationObserver.instance }
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:notification) { create(:notification, actionable: event, user: user)}

  it "should description" do
    NotificationWorker.should_receive(:perform_async).with(notification.id)
    
    # don't turn observer on until we need it
    ActiveRecord::Base.observers.enable :notification_observer

    subject.after_create(notification)
  end
end