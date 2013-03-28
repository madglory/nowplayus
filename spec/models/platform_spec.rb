require 'spec_helper'

describe Platform do
  it { should have_many(:events) }
  it { should validate_presence_of(:name) }

  it "should validate uniqueness of name (case insensitive)" do
    existing_platform = create(:platform, name: 'FOOBAR')
    subject.name = existing_platform.name.downcase
    expect(subject.valid?).to be_false
  end

  describe "#hashtag" do
    subject { create(:platform, name: 'Big Ass Platform Name') }
    context "blank" do
      it "returns the slug stripped of all hyphens and camelcase" do
        expect(subject.hashtag).to eql "##{subject.slug.split('-').map(&:capitalize).join}"
      end
    end
  end
end
