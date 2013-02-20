class ChangeSlotsToTotalPlayers < ActiveRecord::Migration
  def up
    rename_column :events, :slots, :total_players
  end

  def down
    rename_column :events, :total_players, :slots
  end
end
