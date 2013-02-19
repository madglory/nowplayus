class Tweet
  attr_reader :client, :user

  def self.send!(user, message)
    tweet = Tweet.new user
    tweet.update message
  end

  def initialize(user)
    @user = user
    raise TweetException, 'No Twitter Authentication' unless twitter_authentication
    @client = Twitter::Client.new oauth_token: credentials[:token], oauth_token_secret: credentials[:token_secret]
  end

  def update(message)
    client.update message
  end

  class TweetException < Exception; end
private

  def credentials
    raise TweetException, 'No OAuth Token' if twitter_authentication.token.blank?
    {
      token: twitter_authentication.token,
      token_secret: twitter_authentication.token_secret
    }
  end


  def twitter_authentication
    @twitter_authentication ||= user.authentications.find_by_provider('twitter')
  end
end