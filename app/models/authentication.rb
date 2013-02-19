class Authentication < ActiveRecord::Base
  attr_accessible :user_id, :provider, :uid, :token, :token_secret
  belongs_to :user
  validates_presence_of :user_id, :provider, :uid
  validates_uniqueness_of :uid, scope: :provider

  def self.find_from_hash(hash, user=nil)
    find_by_provider_and_uid hash['provider'], hash['uid']
  end

  def self.create_from_hash(hash, user=nil)
    user ||= User.create_from_hash!(hash)
    Authentication.create(
      user_id: user.id,
      uid: hash['uid'],
      provider: hash['provider'],
      token: hash['credentials']['token'],
      token_secret: hash['credentials']['secret']
    )
  end
end
