class CreateTwitterNotifications < ActiveRecord::Migration
  def change
    create_table :twitter_notifications do |t|
      t.references :user
      t.string :message
      t.boolean :sent
      t.timestamps
    end
  end
end
