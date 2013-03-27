require 'spec_helper'

describe NotificationWorker do
  subject { NotificationWorker.new }
  let(:user) { create(:user) }
  let(:notification_setting) { create(:notification_setting, user: user, comment_via_email: true, participant_via_direct_message: true) }
  let(:comment) { create(:comment) }
  let(:participant) { create(:participant) }
  

  before(:each) do
    notification_setting
  end

  describe "#perform" do
    context "with email actionable setting applied" do
      let(:notification) { create(:notification, user: user, actionable: comment) }
      it "should attempt to send an email for an actionable item when the user has the setting applied" do
        deliverable = mock('Deliverable')
        deliverable.should_receive(:deliver)
        NotificationMailer.should_receive(:comment_email).with(notification).and_return(deliverable)
        NotificationDirectMessage.should_not_receive(:comment_direct_message)
        
        subject.perform notification.id
      end
    end

    context "with direct message actionable setting applied" do
      let(:notification) { create(:notification, user: user, actionable: participant) }
      it "should attempt to send a direct_message for an actionable item when the user has the setting applied" do

        deliverable = mock('Deliverable')
        deliverable.should_receive(:deliver)
        NotificationDirectMessage.should_receive(:participant_direct_message).with(notification).and_return(deliverable)
        NotificationMailer.should_not_receive(:participant_email)
        
        subject.perform notification.id
      end
    end

    context "with no notification setting for actionable" do
      let(:notification) { create(:notification, user: user, actionable: comment) }

      before(:each) do
        notification_setting.update_attribute :comment_via_email, false
      end

      it "should not send an email or direct message" do
        NotificationMailer.should_not_receive(:comment_email)
        NotificationDirectMessage.should_not_receive(:comment_direct_message)
        subject.perform notification.id
      end
    end
  end
end