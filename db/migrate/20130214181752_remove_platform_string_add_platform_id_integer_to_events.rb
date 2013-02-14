class RemovePlatformStringAddPlatformIdIntegerToEvents < ActiveRecord::Migration
  def up
    remove_column :events, :platform
    add_column :events, :platform_id, :integer
    add_index :events, :platform_id
  end

  def down
    add_column :events, :platform, :string
    remove_column :events, :platform_id
    remove_index :events, :platform_id
  end
end
