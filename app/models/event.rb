require 'chronic'
require 'chronic_duration'

class Event < ActiveRecord::Base
  attr_accessor :duration_raw, :starts_at_raw
  before_validation :parse_chronic
  before_save :create_new_platform_from_name
  attr_accessible :starts_at_raw, :duration_raw, :description, :slots, :title, :platform_id, :time_zone, :new_platform_name
  attr_accessor :new_platform_name
  acts_as_paranoid

  belongs_to :platform
  belongs_to :user
  has_many :participants
  has_many :players, through: :participants, foreign_key: :user_id, class_name: 'User', source: :user
  accepts_nested_attributes_for :platform, reject_if: ->(attributes) { attributes['name'].blank? }

  validates :user, presence: true
  validates :title, presence: true
  validates :starts_at, presence: true
  validates :duration, presence: true
  validates :slots, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 10 }
  validate :platform_id_or_name_present?

  def bench_players
    players.order('participants.created_at ASC').offset(slots)
  end

  def team_players
    players.order('participants.created_at ASC').limit(slots)
  end

  def host
    user
  end

  def host_name
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

  def slots_filled
    players.count >= slots ? slots : players.count
  end

private
  def parse_chronic
    return false if starts_at_raw.blank? || duration_raw.blank?
    self.starts_at = Chronic.parse(starts_at_raw)
    self.duration = ChronicDuration.parse(duration_raw);
  end

  def create_new_platform_from_name
    create_platform(name: new_platform_name) unless new_platform_name.blank?
  end

  def platform_id_or_name_present?
    errors.add(:platform_id, "must be selected or a new one must be created") if platform_id.blank? && new_platform_name.blank?
    errors.add(:platform_id, "cannot be selected when creating a new one") if platform_id.present? && new_platform_name.present?
  end
end
