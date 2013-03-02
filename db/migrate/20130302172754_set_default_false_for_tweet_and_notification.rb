class SetDefaultFalseForTweetAndNotification < ActiveRecord::Migration
  def up
    change_column :new_participant_notifications, :sent, :boolean, default: false, null: false
    change_column :event_tweets, :sent, :boolean, default: false, null: false
  end

  def down
    change_column :new_participant_notifications, :sent, :boolean
    change_column :event_tweets, :sent, :boolean
  end
end
