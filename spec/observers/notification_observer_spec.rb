require 'spec_helper'

describe NotificationObserver do
  subject { NotificationObserver.instance }
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:notification) { create(:notification, actionable: event, user: user)}

  context "after_create" do
    it "should enqueue a notification job" do
      # don't turn observer on until we need it
      ActiveRecord::Base.observers.enable :notification_observer
      subject.after_create(notification)

      NotificationWorker.jobs.first.should eql({"class" => NotificationWorker, "args" => [1]})
    end
  end
end