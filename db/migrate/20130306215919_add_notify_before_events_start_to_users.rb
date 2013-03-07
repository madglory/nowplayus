class AddNotifyBeforeEventsStartToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notify_before_events_start, :boolean, default: false
  end
end
