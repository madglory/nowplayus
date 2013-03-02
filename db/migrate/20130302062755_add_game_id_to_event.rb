class AddGameIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :game_id, :integer
    add_index :events, :game_id
  end
end
