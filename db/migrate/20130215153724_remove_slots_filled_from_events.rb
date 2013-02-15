class RemoveSlotsFilledFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :slots_filled
  end

  def down
    add_column :events, :slots_filled, :integer
  end
end
