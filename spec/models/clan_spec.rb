require 'spec_helper'

describe Clan do
  it { should have_many(:users).through(:memberships) }
end
