class AddSentToEventTweets < ActiveRecord::Migration
  def change
    add_column :event_tweets, :sent, :boolean
  end
end
