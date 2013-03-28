require 'spec_helper'

describe Game do
  it { should have_many(:events) }

  describe "#hashtag" do
    subject { create(:game, name: 'Big Ass Game Name') }
    context "blank" do
      it "returns the slug stripped of all hyphens and camelcase" do
        expect(subject.hashtag).to eql "##{subject.slug.split('-').map(&:capitalize).join}"
      end
    end
  end
end