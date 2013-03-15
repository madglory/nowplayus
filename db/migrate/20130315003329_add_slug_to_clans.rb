class AddSlugToClans < ActiveRecord::Migration
  def change
    add_column :clans, :slug, :string
    add_index :clans, :slug, unique: true
  end
end
