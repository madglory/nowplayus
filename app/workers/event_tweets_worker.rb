class EventTweetsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(event_tweet_id)
    event_tweet = EventTweet.find event_tweet_id

    if TweetSender.send!(event_tweet)
      event_tweet.set_as_sent!
    end
  end
end