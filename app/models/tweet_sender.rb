class TweetSender
  attr_reader :client, :status, :user

  def self.send_tweet(tweet)
    sender = TweetSender.new tweet
    sender.send!
  end

  def initialize(tweet)
    @user = tweet.user
    @status = tweet.status
    raise TweetSenderError, 'No Twitter Authentication' unless twitter_authentication
    @client = Twitter::Client.new oauth_token: credentials[:token], oauth_token_secret: credentials[:token_secret]
  end

  def send!
    client.update status
  end

  class TweetSenderError < StandardError; end
private

  def credentials
    raise TweetSenderError, 'No OAuth Token' if twitter_authentication.token.blank?
    {
      token: twitter_authentication.token,
      token_secret: twitter_authentication.token_secret
    }
  end


  def twitter_authentication
    @twitter_authentication ||= user.authentications.find_by_provider('twitter')
  end
end