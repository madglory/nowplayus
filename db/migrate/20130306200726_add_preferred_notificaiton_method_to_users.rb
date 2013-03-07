class AddPreferredNotificaitonMethodToUsers < ActiveRecord::Migration
  def change
    add_column :users, :preferred_notification_method, :string
  end
end
