class CreateNotificationSettings < ActiveRecord::Migration
  def up
    create_table :notification_settings do |t|
      t.references :user
      t.boolean :comment_via_email
      t.boolean :comment_via_direct_message
      t.boolean :participant_via_email
      t.boolean :participant_via_direct_message

      t.timestamps
    end
    add_index :notification_settings, :user_id

    User.all.each { |u| u.create_notification_setting }
  end

  def down
    drop_table :notification_settings
  end
end
