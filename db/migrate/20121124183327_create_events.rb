class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|

      t.text :description

      t.string :starts_at_raw
      t.string :duration_raw

      t.datetime :starts_at
      t.integer :duration

      t.integer :slots, :null => false, :default => 1
      t.integer :slots_filled, :null => false, :default => 0
      t.integer :bench_count, :null => false, :default => 0

      t.references :user

      t.timestamps
    end
  end
end
