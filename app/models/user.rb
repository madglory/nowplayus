class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: :slugged

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  has_many :events, :through => :players
  has_many :events_created, :class_name => "Event"

  attr_accessible :username, :email, :password, :password_confirmation

  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password


end
