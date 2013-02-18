class AddKeepNotifiedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :keep_notified, :boolean
  end
end
