class CreatePlatformAccounts < ActiveRecord::Migration
  def change
    create_table :platform_accounts do |t|
      t.references :user
      t.references :platform
      t.string :username

      t.timestamps
    end
    add_index :platform_accounts, :user_id
    add_index :platform_accounts, :platform_id
    add_index :platform_accounts, [:platform_id, :user_id], unique: true
  end
end
