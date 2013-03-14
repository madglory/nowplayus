class CreateClans < ActiveRecord::Migration
  def change
    create_table :clans do |t|
      t.string :name
      t.timestamps
    end

    add_column :users, :clan_id, :integer
  end
end
