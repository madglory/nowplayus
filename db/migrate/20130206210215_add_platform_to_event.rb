class AddPlatformToEvent < ActiveRecord::Migration
  def change
    add_column :events, :platform, :string
  end
end
