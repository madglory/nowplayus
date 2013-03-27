require 'spec_helper'

describe UserObserver do
  subject { UserObserver.instance }
  let(:user) { create(:user) }

  context "after_create" do
    it "should create a NotificationSetting for the new user" do
      user
      ActiveRecord::Base.observers.enable :user_observer

      expect { subject.after_create(user) }.to change(NotificationSetting, :count).by(1)
      NotificationSetting.first.user.should eq(user)
    end
  end
end
