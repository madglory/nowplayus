RSpec.configure do |config|
  # Assure we're testing models in isolation from Observer behavior. Enable
  # them explicitly in a block if you need to integrate against an Observer --
  # see the documentation for {ActiveModel::ObserverArray}.
  config.before do
    ActiveRecord::Base.observers.disable :all
  end

  # Integration tests are full-stack, lack of isolation is by design.
  config.before(type: :feature) do
    ActiveRecord::Base.observers.enable :all
  end
end