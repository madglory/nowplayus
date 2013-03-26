class RemoveNotificationColumnsFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :preferred_notification_method
    remove_column :users, :notify_for_new_participants
    remove_column :users, :notify_for_new_comments
    remove_column :users, :notify_before_events_start
  end

  def down
    add_column :users, :preferred_notification_method, :string
    add_column :users, :notify_for_new_participants, :boolean, default: false
    add_column :users, :notify_for_new_comments, :boolean, default: false
    add_column :users, :notify_before_events_start, :boolean, default: false
  end
end
