require 'chronic'
require 'chronic_duration'

class Event < ActiveRecord::Base
  before_save :parse_chronic
  attr_accessible :starts_at_raw, :duration_raw, :description, :slots, :title, :platform

  has_many :players
  has_many :users, :through => :players

  belongs_to :user
  validates :user_id, :presence => true
  validates :title, :presence => true
  validates :platform, :presence => true
  validates :starts_at, :presence => true
  validates :duration, :presence => true
  validates :slots, :presence => true, :numericality => { :only_integer => true, :greater_than => 0, :less_than => 10 }

protected
  def parse_chronic
    self.starts_at = Chronic.parse(self.starts_at_raw)
    self.duration = ChronicDuration.parse(self.duration_raw);
  end
end
