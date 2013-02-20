require 'chronic'
require 'chronic_duration'

class Event < ActiveRecord::Base
  attr_accessor :duration_raw, :starts_at_raw
  before_validation :parse_chronic
  attr_accessible :starts_at_raw, :duration_raw, :description, :total_players, :title, :platform_id, :time_zone
  acts_as_paranoid

  belongs_to :platform
  belongs_to :user
  has_many :participants
  has_many :players, through: :participants, foreign_key: :user_id, class_name: 'User', source: :user, order: 'created_at ASC'

  accepts_nested_attributes_for :platform, reject_if: ->(attributes) { attributes['name'].blank? }

  validates :user, presence: true
  validates :title, presence: true
  validates :starts_at, presence: true
  validates :duration, presence: true
  validates :total_players, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 10 }
  validates :platform, presence: true


  def self.past(cut_off=nil, clock=Time.zone)
    events = where(["starts_at < ?", clock.now.utc]).order("starts_at DESC")
    if cut_off
      events.limit(cut_off)
    else
      events
    end
  end

  def self.future(cut_off=nil, clock=Time.zone)
    events = where(["starts_at >= ?", clock.now.utc]).order("starts_at ASC")
    if cut_off
      events.limit(cut_off)
    else
      events
    end
  end

  def bench_players
    players.drop(total_players)
  end

  def team_players
    players.first(total_players)
  end

  def host
    user
  end

  def host_name
    return if user.blank?
    user.username
  end

  def platform_name
    return if platform.blank?
    platform.name
  end

  def host_avatar_url
    return if user.blank?
    user.avatar_url
  end

  def scheduled_start
    return '' if starts_at.blank?
    starts_at.to_s :time
  end

  def scheduled_end
    return '' if duration.blank? || starts_at.blank?
    (starts_at + duration).to_s :time
  end

  def player_count
    players.count
  end

  def past?
    starts_at < Time.zone.now ? true : false if starts_at.present?
  end
 
  def upcoming?
    past? == false
  end

private
  def parse_chronic
    return false if starts_at_raw.blank? || duration_raw.blank?
    Chronic.time_class = Time.zone
    event_time = Chronic.parse starts_at_raw
    self.starts_at = event_time.utc
    self.duration = ChronicDuration.parse duration_raw
  end
end
