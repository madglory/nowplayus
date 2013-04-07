require 'spec_helper'

describe Followed do

  class FollowedThing
    include Followed
    def initialize; end
    def id; 123 end
  end

  subject { FollowedThing.new }

  describe "#followed_redis_key" do
    it "returns a redis key for the object" do
      expect(subject.followed_redis_key('something')).to eql 'followedthing:123:something'
    end
  end

  context "followed methods" do
    let(:user) { create(:user) }
    let(:user_2) { create(:user) }

    before(:each) do
      $redis.sadd("user:#{user.id}:followedthing:following", 123)
      $redis.sadd("followedthing:123:user:followers", user.id)  
    end

    describe "#followers" do
      it "returns the users following the object" do
        expect(subject.followers).to eq [user]
      end
    end

    describe "#followed_by?" do
      it "returns true if the user is following the object" do
        expect(subject.followed_by?(user)).to be_true
      end

      it "returns false if the user is not following the object" do
        expect(subject.followed_by?(user_2)).to be_false
      end
    end

    describe "#followers_count" do
      it "returns the number of followers for the object" do
        expect(subject.followers_count).to eq 1
      end
    end
  end
end