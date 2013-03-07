class ChangeNotificationColumnsOnUsers < ActiveRecord::Migration
  def up
    rename_column :users, :notify_via_email, :send_newsletter
    add_column :users, :notify_for_new_participants, :boolean, default: false
    add_column :users, :notify_for_new_comments, :boolean, default: false
  end

  def down
    rename_column :users, :send_newsletter, :notify_via_email
    remove_column :users, :notify_for_new_participants
    remove_column :users, :notify_for_new_comments
  end
end
