class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: :slugged
  attr_accessible :username, :email, :password, :password_confirmation, :time_zone, :notify_via_email, :avatar_url, :bio

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  before_save :bigger_twitter_avatar, if: ->(user) { user.avatar_url =~ /twimg/ }

  has_many :authentications, dependent: :destroy
  has_many :comments
  has_many :events, through: :participants
  has_many :event_tweets
  has_many :hosted_events, class_name: 'Event'
  has_many :notification_subscriptions
  has_many :participants
  has_many :platform_accounts, dependent: :destroy
  has_many :twitter_notifications
  has_many :memberships
  has_many :clans, through: :memberships

  accepts_nested_attributes_for :authentications
  accepts_nested_attributes_for :clans
  accepts_nested_attributes_for :platform_accounts, reject_if: :all_blank, allow_destroy: true

  validates :username, presence: true, uniqueness: true
  validates_presence_of :time_zone, on: :update
  validates_presence_of :email, on: :update
  validates_length_of :password, minimum: 3, message: "must be at least 3 characters long", if: 'password.present?'
  validates_confirmation_of :password, message: "should match confirmation", if: 'password.present?'

  def self.create_from_hash!(hash)
    create(
      username: hash['info']['nickname'],
      avatar_url: hash['info']['image'],
      email: hash['info']['email'],
      bio: hash['info']['description'])
  end

  def update_from_hash!(hash)
    details = {
      avatar_url: hash['info']['image']
    }
    update_attributes details
  end

  def registration_complete?
    email.present? && time_zone.present?
  end

  def available_notification_methods
    authentications.map(&:provider) << 'email'
  end

  def platform_username(platform)
    if platform_account = platform_accounts.select('username').find_by_platform_id(platform)
      platform_account.username
    else
      username
    end
  end
private
  def bigger_twitter_avatar
    self.avatar_url.sub! /_normal/, ''
  end
end