class Tweet
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :user, :event, :status

  validates_presence_of :user, :event, :status
  validates_length_of :status, maximum: 140, minimum: 1

  def initialize(attributes = {})
    attributes.each { |k,v| send("#{k}=", v) }
    self.status ||= default_status unless event.blank? || user.blank?
  end

  def persisted?
    false
  end

private

  def default_status
    event.host == user ? default_host_status : default_player_status
  end

  def default_player_status
    "Join me, @#{event.host_name} and #{event.total_players - 1} others for a game of #{event.title} http://nowplay.us/events/#{event.id} via @nowplayus ##{event.platform_name.gsub(/\s/,'')}"
  end

  def default_host_status
    "Join me for a game of #{event.title} http://nowplay.us/events/#{event.id} via @nowplayus ##{event.platform_name.gsub(/\s/,'')}"
  end
end