class Player < ActiveRecord::Base
  attr_accessible :event_id, :status, :user_id

  belongs_to :user
  belongs_to :event

end
