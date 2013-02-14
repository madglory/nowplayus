require 'chronic'
require 'chronic_duration'

class Event < ActiveRecord::Base
  attr_accessor :duration_raw, :starts_at_raw
  before_validation :parse_chronic
  attr_accessible :starts_at_raw, :duration_raw, :description, :slots, :title, :platform, :time_zone
  acts_as_paranoid

  has_many :players, dependent: :destroy
  belongs_to :user
  belongs_to :platform

  validates :user, presence: true
  validates :title, presence: true
  validates :platform, presence: true
  validates :starts_at, presence: true
  validates :duration, presence: true
  validates :slots, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 10 }

  def host
    return if user.blank?
    user.username
  end

  def platform_name
    return if user.blank?
    platform.name
  end

  def host_avatar_url
    return if user.blank?
    user.avatar_url
  end

  def scheduled_time_with_duration
    "#{scheduled_start} - #{scheduled_end} #{scheduled_timezone}"
  end

  def scheduled_start
    return '' if starts_at.blank?
    starts_at.to_s :time
  end

  def scheduled_end
    return '' if duration.blank? || starts_at.blank?
    (starts_at + duration).to_s :time
  end

  def scheduled_timezone
    return '' if starts_at.blank?
    ActiveSupport::TimeZone.new(user.time_zone).now.to_s :time_zone
  end

private
  def parse_chronic
    return false if starts_at_raw.blank? || duration_raw.blank?
    self.starts_at = Chronic.parse(starts_at_raw)
    self.duration = ChronicDuration.parse(duration_raw);
  end
end
