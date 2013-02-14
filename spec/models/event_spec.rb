require 'spec_helper'

describe Event do
  let(:user) { create :user }
  let(:platform) { create :platform }
  subject do 
    Event.new(
      title: 'Foo',
      platform: platform,
      slots: 5,
      starts_at_raw: 'Tomorrow 5pm',
      duration_raw: '5hr')
  end

  before(:each) do
    subject.user = user
  end

  it { should have_many(:players) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:platform) }
  it { should validate_presence_of(:slots) }
  it { should validate_numericality_of(:slots) }

  it "should validate between 0 and 10 slots" do
    expect(subject.valid?).to be_true
    subject.slots = 0
    expect(subject.valid?).to be_false

    9.times do |n|
      subject.slots = n+1
      expect(subject.valid?).to be_true
    end

    subject.slots = 10
    expect(subject.valid?).to be_false
  end

  it "should validate presence of user" do
    expect(subject.valid?).to be_true
    subject.user = nil
    expect(subject.valid?).to be_false
  end

  it "should validate presence of starts_at" do
    expect(subject.valid?).to be_true
    subject.starts_at_raw = nil
    expect(subject.valid?).to be_false
  end

  it "should validate presence of duration" do
    expect(subject.valid?).to be_true
    subject.duration_raw = nil
    expect(subject.valid?).to be_false
  end

  describe "#destroy should soft delete" do
    before(:each) do
      subject.save
    end
    it "should not remove the record" do
      subject.destroy
      expect(subject.persisted?).to be_true
    end

    it "should have a datetime in the deleted_at column" do
      subject.destroy
      expect(subject.deleted_at.present?).to be_true
    end
  end
end