class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: :slugged
  attr_accessible :username, :email, :password, :password_confirmation, :time_zone

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, dependent: :destroy
  has_many :platform_accounts, dependent: :destroy
  has_many :participants
  has_many :events, through: :participants
  has_many :events_created, class_name: 'Event'

  accepts_nested_attributes_for :authentications
  accepts_nested_attributes_for :platform_accounts, reject_if: :all_blank, allow_destroy: true

  validates :username, presence: true
  validates :time_zone, presence: true
  validates_length_of :password, minimum: 3, message: "password must be at least 3 characters long", if: 'password.present?'
  validates_confirmation_of :password, message: "should match confirmation", if: 'password.present?'

  def platform_username(platform)
    platform_accounts.select('username').find_by_platform_id(platform)
  end
end