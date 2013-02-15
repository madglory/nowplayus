class RenamePlayersToParticipants < ActiveRecord::Migration
  def up
    rename_table :players, :participants
  end

  def down
    rename_table :participants, :players
  end
end
