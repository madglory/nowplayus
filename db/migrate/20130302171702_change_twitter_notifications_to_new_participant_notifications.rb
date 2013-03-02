class ChangeTwitterNotificationsToNewParticipantNotifications < ActiveRecord::Migration
  def up
    rename_table :twitter_notifications, :new_participant_notifications
    rename_column :new_participant_notifications, :user_id, :host_id
    add_column :new_participant_notifications, :participant_id, :integer
    add_column :new_participant_notifications, :event_id, :integer
  end

  def down
    remove_column :new_participant_notifications, :event_id
    remove_column :new_participant_notifications, :participant_id
    rename_column :new_participant_notifications, :host_id, :user_id
    rename_table :new_participant_notifications, :twitter_notifications
  end
end
