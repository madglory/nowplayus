class CreateEventTweets < ActiveRecord::Migration
  def change
    create_table :event_tweets do |t|
      t.references :event
      t.references :user
      t.string :status

      t.timestamps
    end
  end
end
