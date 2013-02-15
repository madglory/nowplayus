class RemoveStatusFromPlayers < ActiveRecord::Migration
  def up
    remove_column :players, :status
  end

  def down
    add_column :players, :status, :string
  end
end
