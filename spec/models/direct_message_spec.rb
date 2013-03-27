require 'spec_helper'

describe DirectMessage do
  let(:user) { create(:user) }
  let(:message) { 'pew pew pew... lasers' }
  let(:authentication) { create(:authentication, user: user, provider: 'twitter', token: 'fake oauth token', token_secret: 'ssshhhhh....') }
  
  it "should raise an exception if no authentication is found" do
    expect{ DirectMessage.new user, message }.to raise_error(DirectMessage::DirectMessageError, "No Twitter Authentication")
  end

  describe "#deliver" do
    subject { DirectMessage.new user, message }

    before(:each) do
      authentication
    end

    it "should create a direct message" do
      subject.nowplayus.should_receive(:direct_message_create).with(authentication.uid.to_i, message)
      subject.deliver
    end
  end
end