class AddSlugToPlatforms < ActiveRecord::Migration
  def up
    add_column :platforms, :slug, :string
    add_index :platforms, :slug, unique: true

    Platform.all.each { |p| p.save }
  end

  def down
    remove_column :platforms, :slug
    remove_index :platforms, :slug
  end
end
