class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user
      t.string :actionable_type
      t.integer :actionable_id
      t.datetime :viewed_at

      t.timestamps
    end
    add_index :notifications, :user_id
    add_index :notifications, [:actionable_type, :actionable_id]
  end
end
