class Notification < ActiveRecord::Base
  attr_accessible :actionable_id, :actionable_type, :viewed_at

  belongs_to :user
  belongs_to :actionable, polymorphic: true

  validates_presence_of :user, :actionable
end
