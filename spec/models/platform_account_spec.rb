require 'spec_helper'

describe PlatformAccount do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:platform) }
  it { should validate_presence_of(:username) }
end