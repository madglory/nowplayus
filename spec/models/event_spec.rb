require 'spec_helper'

describe Event do
  let(:user) { create :user }
  let(:platform) { create :platform }
  let(:game) { create :game }
  subject do
    Event.new(
      platform_id: platform.id,
      total_players: 5,
      starts_at_raw: 'Tomorrow 5pm',
      duration_raw: '5hr')
  end

  before(:each) do
    subject.user = user
    subject.game = game
  end

  it { should have_many(:participants) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:total_players) }
  it { should validate_numericality_of(:total_players) }
  it { should validate_presence_of(:platform) }


  it "should validate between 0 and 19 total_players" do
    expect(subject.valid?).to be_true
    subject.total_players = 0
    expect(subject.valid?).to be_false

    (2..18).each do |n|
      subject.total_players = n
      expect(subject.valid?).to be_true
    end

    subject.total_players = 19
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