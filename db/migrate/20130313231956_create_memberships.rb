class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :clan_id
      t.timestamps
    end

    add_index :memberships, :user_id
    add_index :memberships, :clan_id
    add_index :memberships, [:user_id, :clan_id], unique: true
  end
end
