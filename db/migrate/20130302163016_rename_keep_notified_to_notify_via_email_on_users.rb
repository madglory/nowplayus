class RenameKeepNotifiedToNotifyViaEmailOnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :keep_notified, :notify_via_email
  end
end
