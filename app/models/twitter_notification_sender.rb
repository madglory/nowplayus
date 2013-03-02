class TwitterNotificationSender
  attr_reader :nowplayus, :message, :user, :recipient

  def initialize(twitter_notification)
    @user = twitter_notification.user
    @message = twitter_notification.message
    raise TwitterNotificationError, 'No Twitter Authentication' unless twitter_authentication
    @nowplayus = Twitter::Client.new oauth_token: ENV['TWITTER_OAUTH_TOKEN'], oauth_token_secret: ENV['TWITTER_OAUTH_TOKEN_SECRET']
    @recipient = Twitter::Client.new oauth_token: credentials[:token], oauth_token_secret: credentials[:token_secret]
  end

  def self.send!(twitter_notification)
    sender = TwitterNotificationSender.new twitter_notification
    sender.send!
  end

  def send!
    # send regardless of whether or not they're following @nowplayus
    nowplayus.direct_message_create credentials[:uid].to_i, message
  end

  class TwitterNotificationSenderError < StandardError; end
private

  def credentials
    raise TwitterNotificationError, 'No OAuth Token' if twitter_authentication.token.blank?
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