require 'spec_helper'

describe Following do
  class FollowingThing
    include Following
    def initialize; end
    def id; 1234 end
  end

  subject { FollowingThing.new }

  describe "#following_redis_key" do
    it "returns a redis key for the object" do
      expect(subject.following_redis_key('something')).to eql "followingthing:#{subject.id}:something"
    end
  end

  context "following methods" do
    let(:game) { create(:game) }

    describe "#follow!" do
      before :each do
        subject.follow! game
      end

      it "adds the followed object's id to the following object's following_redis_key" do
        expect($redis.smembers("followingthing:#{subject.id}:#{game.class.to_s.downcase}:following").include?(game.id.to_s)).to be_true
      end

      it "adds the object id to the followed object's followers key" do
        expect($redis.smembers("#{game.class.to_s.downcase}:#{game.id}:#{subject.class.to_s.downcase}:followers").include?(subject.id.to_s)).to be_true
      end
    end

    describe "#unfollow!" do
      before :each do
        subject.follow! game
      end

      it "removes the followed object's id from the following object's following_redis_key" do
        expect($redis.smembers("followingthing:#{subject.id}:#{game.class.to_s.downcase}:following").include?(game.id.to_s)).to be_true
        subject.unfollow! game
        expect($redis.smembers("followingthing:#{subject.id}:#{game.class.to_s.downcase}:following").include?(game.id.to_s)).to be_false 
      end

      it "removes the object id from the followed object's followers key" do
        expect($redis.smembers("#{game.class.to_s.downcase}:#{game.id}:#{subject.class.to_s.downcase}:followers").include?(subject.id.to_s)).to be_true
        subject.unfollow! game
        expect($redis.smembers("#{game.class.to_s.downcase}:#{game.id}:#{subject.class.to_s.downcase}:followers").include?(subject.id.to_s)).to be_false
      end
    end

    describe "#friends" do
      let(:user) { create(:user) }
      let(:user_2) { create(:user) }

      it "returns the users that someone is following that also follow them" do
        user.follow! user_2
        user_2.follow! user

        expect(user.friends.include?(user_2)).to be_true
        expect(user_2.friends.include?(user)).to be_true
      end
    end

    describe "#following?" do

      it "should return true if object is followed by FollowingThing" do
        subject.follow! game
        expect(subject.following?(game)).to be_true
      end

      it "should return false if object is not followed by FollowingThing" do
        expect(subject.following?(game)).to be_false
      end
    end

    describe "#following_count" do
      it "returns the number of objects the FollowingThing is following for the given object type" do
        subject.follow! game
        expect(subject.following_count(Game)).to eql 1
        expect(subject.following_count).to eql 0 # defaults to User
      end
    end

    describe "#following" do
      let(:user) { create(:user) }
      it "returns an array of the instances of FollowingThing's that are following the given object type" do
        user.follow! game
        expect(user.following('games')).to eq [game]
        expect(user.following).to eq [] # defaults to User
      end
    end
  end
end