class RemoveUniqueIndexFromPlatformAccounts < ActiveRecord::Migration
  def up
    add_index :platform_accounts, [:username, :platform_id], unique: true
    remove_index :platform_accounts, [:platform_id, :user_id]
  end

  def down
    add_index :platform_accounts, [:platform_id, :user_id], unique: true
    remove_index :platform_accounts, [:username, :platform_id]
  end
end
