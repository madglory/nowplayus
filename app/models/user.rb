class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: :slugged
  attr_accessible :username, :email, :password, :password_confirmation, :time_zone

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  has_many :players
  has_many :events, through: :players
  has_many :events_created, class_name: "Event"


  validates :username, presence: true
  validates :time_zone, presence: true
  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password
end