class Authentication < ActiveRecord::Base
  attr_accessible :user_id, :provider, :uid, :token, :token_secret, :nickname
  belongs_to :user
  validates_presence_of :user_id, :provider, :uid
  validates_uniqueness_of :uid, scope: :provider

  def self.find_from_hash(hash, user=nil)
    find_by_provider_and_uid hash['provider'], hash['uid']
  end

  def self.create_from_hash!(hash, user=nil)
    user ||= User.create_from_hash!(hash)
    Authentication.create(
      user_id: user.id,
      uid: hash['uid'],
      provider: hash['provider'],
      nickname: hash['info']['nickname'],
      # ensure the token/secret hash keys are universal and not Twitter specific
      token: hash['credentials']['token'], 
      token_secret: hash['credentials']['secret']
    )
  end

  def update_from_hash!(hash)
    details = {
      nickname: hash['info']['nickname'],
      token: hash['credentials']['token'],
      token_secret: hash['credentials']['secret']
    }
    update_attributes details
  end
end
