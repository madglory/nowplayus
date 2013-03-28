require 'spec_helper'

describe EventTweet do
  let(:user) { create(:user) }
  let(:event) { create(:event, user: user) }
  subject { EventTweet.new user: user, event: event }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:event) }

  context ":status" do
    context "default host status" do
      context "future event" do
        before :each do
          event.update_attributes starts_at_raw: 'tomorrow at 3pm', duration_raw: '1hr'
        end

        it "should set default status to 'Join me...' on initailize" do
          expect(EventTweet.new(user: user, event: event).status).to match(/\AJoin me for a game of #{event.title} via @nowplayus #{event_url(event)} #{event.platform_hashtag} #{event.game_hashtag}\z/)
        end
      end

      context "past event" do
        before :each do
          event.update_attributes starts_at_raw: 'yesterday at 3pm', duration_raw: '1hr'
        end

        it "should set default status to 'Played a game of...'" do
          expect(EventTweet.new(user: user, event: event).status).to match(/\APlayed a game of #{event.title} via @nowplayus #{event_url(event)} #{event.platform_hashtag} #{event.game_hashtag}\z/)
        end
      end
    end

    context "default player status" do
      let(:other_user) { create(:user) }
      before :each do
        event.update_attribute :user, other_user
      end

      context "future event" do
        before(:each) do
          event.update_attributes starts_at_raw: 'tomorrow at 3pm', duration_raw: '1hr'
        end

        it "should set default status to 'Join me, @host...' on initailize" do
          expect(EventTweet.new(user: user, event: event).status).to match(/\AJoin me, @#{event.host_name} and others for a game of #{event.title} via @nowplayus #{event_url(event)} #{event.platform_hashtag} #{event.game_hashtag}\z/)
        end
      end

      context "past event" do
        before(:each) do
          event.update_attributes starts_at_raw: 'yesterday at 3pm', duration_raw: '1hr'
        end

        it "should set default status to 'Joined @host and others...' on initailize" do
          expect(EventTweet.new(user: user, event: event).status).to match(/\AJoined @#{event.host_name} and others for a game of #{event.title} via @nowplayus #{event_url(event)} #{event.platform_hashtag} #{event.game_hashtag}\z/)
        end
      end
    end

    it "should validate maximum length of 140" do
      expect(subject.valid?).to be_true
      subject.status = "a"*141
      expect(subject.valid?).to be_false
    end

    it "should validate minimum length of 1" do
      expect(subject.valid?).to be_true
      subject.status = ''
      expect(subject.valid?).to be_false
    end
  end

  describe "#set_as_sent!" do
    it "should update the sent attribute to true" do
      expect(subject.sent).to be_false
      subject.set_as_sent!
      expect(subject.sent).to be_true
    end
  end
end