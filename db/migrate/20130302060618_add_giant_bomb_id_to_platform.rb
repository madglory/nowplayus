class AddGiantBombIdToPlatform < ActiveRecord::Migration
  def change
    add_column :platforms, :giantbomb_id, :integer
    add_index :platforms, :giantbomb_id, :unique => true
  end
end
