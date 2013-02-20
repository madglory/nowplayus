class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: :slugged
  attr_accessible :username, :email, :password, :password_confirmation, :time_zone, :keep_notified, :avatar_url

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, dependent: :destroy
  has_many :platform_accounts, dependent: :destroy
  has_many :participants
  has_many :events, through: :participants
  has_many :hosted_events, class_name: 'Event'

  accepts_nested_attributes_for :authentications
  accepts_nested_attributes_for :platform_accounts, reject_if: :all_blank, allow_destroy: true

  validates :username, presence: true, uniqueness: true
  validates_presence_of :time_zone, on: :update
  validates_presence_of :email, on: :update
  validates_length_of :password, minimum: 3, message: "must be at least 3 characters long", if: 'password.present?'
  validates_confirmation_of :password, message: "should match confirmation", if: 'password.present?'

  def self.create_from_hash!(hash)
    create username: hash['info']['nickname'], avatar_url: hash['info']['image']
  end

  def registration_complete?
    email.present? && time_zone.present?
  end

  def platform_username(platform)
    if platform_account = platform_accounts.select('username').find_by_platform_id(platform)
      platform_account.username
    else
      username
    end
  end
end