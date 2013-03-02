class AddNotifyHostOnEvents < ActiveRecord::Migration
  def change
    add_column :events, :notify_host, :boolean
  end
end
