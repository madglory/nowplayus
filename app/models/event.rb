require 'chronic'
require 'chronic_duration'

class Event < ActiveRecord::Base
  attr_accessor :duration_raw, :starts_at_raw
  attr_accessible :starts_at_raw, :duration_raw, :description, :total_players, :platform_id, :notify_host, :game_id

  acts_as_paranoid
  acts_as_commentable

  belongs_to :platform
  belongs_to :user
  belongs_to :game
  has_many :participants
  has_many :players, through: :participants, foreign_key: :user_id, class_name: 'User', source: :user, order: 'created_at ASC'
  has_many :event_tweets
  has_many :new_participant_notifications

  validates :game, presence: true
  validates :user, presence: true
  validate :starts_at_raw_present_and_parseable?
  validate :duration_raw_present_and_parseable?
  validates :starts_at, presence: true
  validates :duration, presence: true
  validates :total_players, presence: true, numericality: { only_integer: true, greater_than: 1, less_than: 19 }
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
    events = where(["(starts_at + duration*INTERVAL '1 second') >= ?", clock.now.utc]).order("starts_at ASC")
    if cut_off
      events.limit(cut_off)
    else
      events
    end
  end

  def title
    return '' if game.blank?
    game.name
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

  def scheduled_start(without_time_zone=false)
    return '' if starts_at.blank?
    without_time_zone ? starts_at.to_s(:time) : starts_at.to_s(:time_with_zone)
  end

  def scheduled_end
    return '' if duration.blank? || starts_at.blank?
    (starts_at + duration).to_s :time
  end

  def player_count
    players.count
  end

  def past?
    starts_at+duration < Time.zone.now ? true : false if starts_at.present? and duration.present?
  end

  def upcoming?
    past? == false
  end

private
  def starts_at_raw_present_and_parseable?
    if event_time = Chronic.parse(starts_at_raw)
      self.starts_at = event_time
    else
      errors.add :starts_at_raw, 'is not a valid date/time'
    end
  end

  def duration_raw_present_and_parseable?
    if event_duration = Chronic.parse(duration_raw)
      self.duration = event_duration
    else
      errors.add :duration_raw, 'is not a valid duration'
    end
  end
end
