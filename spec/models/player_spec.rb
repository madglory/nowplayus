require 'spec_helper'

describe Participant do
  let(:user) { create(:user) }
  let(:event) { create(:event, user: user) }

  subject { Participant.new user_id: user.id, event_id: event.id }
end