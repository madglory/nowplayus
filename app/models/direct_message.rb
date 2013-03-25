class DirectMessage
  attr_reader :nowplayus, :message, :user, :recipient

  def initialize(user, message)
    @user = user
    @message = message
    
    raise DirectMessageError, 'No Twitter Authentication' unless twitter_authentication
    
    @nowplayus = Twitter::Client.new(
      oauth_token: ENV['TWITTER_NOTIFICATION_TOKEN'],
      oauth_token_secret: ENV['TWITTER_NOTIFICATION_TOKEN_SECRET'],
      consumer_key: ENV['TWITTER_NOTIFICATION_KEY'],
      consumer_secret: ENV['TWITTER_NOTIFICATION_SECRET'])

    @recipient = Twitter::Client.new(
      oauth_token: credentials[:token],
      oauth_token_secret: credentials[:token_secret])
  end

  def deliver
    # send regardless of whether or not they're following @nowplayus
    nowplayus.direct_message_create credentials[:uid].to_i, message
  end

  class TwitterNotificationSenderError < StandardError; end
private

  def credentials
    raise DirectMessageError, 'No OAuth Token' if twitter_authentication.token.blank?
    {
      uid: twitter_authentication.uid,
      token: twitter_authentication.token,
      token_secret: twitter_authentication.token_secret
    }
  end

  def twitter_authentication
    @twitter_authentication ||= user.authentications.find_by_provider('twitter')
  end
end