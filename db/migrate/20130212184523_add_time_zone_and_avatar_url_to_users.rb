class AddTimeZoneAndAvatarUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :time_zone, :string
    add_column :users, :avatar_url, :string
  end
end
