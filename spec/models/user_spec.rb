require 'spec_helper'

describe User do
  it { should have_many(:authentications).dependent(:destroy) }
  it { should have_many(:platform_accounts).dependent(:destroy) }
  it { should have_many(:participants) }
  it { should have_many(:events).through(:participants) }
  it { should have_many(:events_created).class_name('Event') }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:time_zone) }
  it { should ensure_length_of(:password).is_at_least(3).with_message(/must be at least \d characters long/) }

  describe "#registration_complete?" do
    subject { User.new username: 'Foo', time_zone: 'Tijuana', email: 'claptrap@madgloryint.com' }
    context "email and time_zone present" do
      it(:registration_complete?) { should be_true }
    end

    context "email blank" do
      it "should be false" do
        subject.email = nil
        expect(subject.registration_complete?).to be_false
      end
    end

    context "email blank" do
      it "should be false" do
        subject.email = nil
        expect(subject.registration_complete?).to be_false
      end
    end
  end
end