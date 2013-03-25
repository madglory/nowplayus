require 'spec_helper'

describe Game do
  it { should have_many(:events) }

  describe "#hashtag" do
    subject { create(:game) }
    context "blank" do
      it "returns the name, stripped of all non-word characters" do
        expect(subject.hashtag).to eql "##{subject.name.gsub(/\W/,'')}"
      end
    end

    context "not blank" do
      it "returns the hashtag, stripped of all non-word characters" do
        subject.hashtag = "#FREAKING AWESOME!!!"
        expect(subject.hashtag).to eql "#FREAKINGAWESOME"
      end
    end
  end
end