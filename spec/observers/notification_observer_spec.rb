require 'spec_helper'

describe NotificationObserver do
  subject { NotificationObserver.instance }
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:notification) { create(:notification, actionable: event, user: user)}

  context "after_create" do
    it "should enqueue a notification job at a later time (15 seconds)" do
      # don't turn observer on until we need it
      ActiveRecord::Base.observers.enable :notification_observer
      subject.after_create(notification)

      expect(NotificationWorker.jobs.first['class']).to eql NotificationWorker
      expect(NotificationWorker.jobs.first['args']).to eql [1]
      expect(NotificationWorker.jobs.first.keys.include?("at")).to be_true
    end
  end
end