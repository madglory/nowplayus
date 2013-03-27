require 'spec_helper'

describe NotificationMailer do
  let(:user) { create(:user, email: 'foo@example.com') }
  let(:event) { create(:event) }
  let(:notification_subscription) { create(:notification_subscription, user: user, subscribable: event)}
  let(:comment) { create(:comment, commentable: event) }
  let(:participant) { create(:participant, event: event) }

  before(:each) do
    notification_subscription
  end

  describe "comment_email" do
    let(:notification) { create(:notification, user: user, actionable: comment) }
    subject { NotificationMailer.comment_email(notification) }

    it "should send a new comment notification" do
      expect(subject.subject).to eql "New comment on #{comment.commentable}"
      expect(subject.to).to eql [user.email]
      expect(subject.from).to eql ['notifier@nowplay.us']
    end

    it "should be multipart" do
      expect(subject.multipart?).to be_true
    end

    it "should render the body with a link to the comment" do
      expect(subject.body.encoded).to match("http://nowplay.us/comments/#{comment.id}")
    end

    it "should render the body with a link to unwatch the event" do
      expect(subject.body.encoded).to match("http://nowplay.us/unwatch/#{notification_subscription.to_param}")
    end
  end

  describe "participant_email" do
    let(:notification) { create(:notification, user: user, actionable: participant) }
    subject { NotificationMailer.participant_email(notification) }
    
    it "should send a new participant notification" do
      expect(subject.subject).to eql "#{participant.user} just joined the event for #{participant.event}"
      expect(subject.to).to eql [user.email]
      expect(subject.from).to eql ['notifier@nowplay.us']
    end

    it "should be multipart" do
      expect(subject.multipart?).to be_true
    end

    it "should render the body with a link to the event" do
      expect(subject.body.encoded).to match("http://nowplay.us/events/#{event.id}")
    end

    it "should render the body with a link to unwatch the event" do
      expect(subject.body.encoded).to match("http://nowplay.us/unwatch/#{notification_subscription.to_param}")
    end
  end
end