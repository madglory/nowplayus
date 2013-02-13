class RemoveDurationRawAndStartsAtRawColumnsFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :duration_raw
    remove_column :events, :starts_at_raw
  end

  def down
    add_column :events, :duration_raw, :string
    add_column :events, :starts_at_raw, :string
  end
end
