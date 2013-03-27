require 'spec_helper'

describe NotificationSubscription do
  it { should belong_to(:user) }
  it { should belong_to(:subscribable) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:subscribable) }


  let(:event) { create(:event) }
  let(:user) { create(:user) }

  describe "#find_by_param" do
    it "should split param by hyphen and find_by_user_id_and_id" do
      ns = NotificationSubscription.create user_id: user.id, subscribable_id: event.id, subscribable_type: 'Event'
      NotificationSubscription.find_by_param("#{user.id}-#{ns.id}").should eql ns
    end
  end

  describe "#to_param" do
    it "should return a string of the 'user_id-id'" do
      ns = NotificationSubscription.create user_id: user.id, subscribable_id: event.id, subscribable_type: 'Event'
      ns.to_param.should eql "#{user.id}-#{ns.id}"
    end
  end
end