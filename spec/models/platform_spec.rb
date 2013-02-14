require 'spec_helper'

describe Platform do
  it { should have_many(:events) }
  it { should validate_presence_of(:name) }

  it "should validate uniqueness of name (case insensitive)" do
    existing_platform = create(:platform, name: 'FOOBAR')
    subject.name = existing_platform.name.downcase
    expect(subject.valid?).to be_false
  end
end
