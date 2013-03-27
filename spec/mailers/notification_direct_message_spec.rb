require 'spec_helper'

describe NotificationDirectMessage do
  let(:user) { create(:user) }
  let(:comment) { create(:comment) }
  let(:participant) { create(:participant) }
  let(:comment_notification) { create(:notification, actionable: comment, user: user) }
  let(:participant_notification) { create(:notification, actionable: participant, user: user) }
  let(:decorator) { OpenStruct.new twitter_message: 'foobar' }

  describe "self#comment_direct_message" do
    it "should create a DirectMessage" do
      CommentNotificationDecorator.should_receive(:new).with(comment_notification).and_return(decorator)
      DirectMessage.should_receive(:new).with(user,decorator.twitter_message)

      NotificationDirectMessage.comment_direct_message(comment_notification)
    end
  end

  describe "self#participant_direct_message" do
    it "should create a DirectMessage" do
      ParticipantNotificationDecorator.should_receive(:new).with(participant_notification).and_return(decorator)
      DirectMessage.should_receive(:new).with(user,decorator.twitter_message)

      NotificationDirectMessage.participant_direct_message(participant_notification)
    end
  end
end