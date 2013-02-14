class CreatePlatforms < ActiveRecord::Migration
  def up
    create_table :platforms do |t|
      t.string :name

      t.timestamps
    end
    execute "CREATE UNIQUE INDEX index_platforms_on_lowercase_name 
             ON platforms USING btree (lower(name));"
  end

  def down
    drop_table :platforms
    execute "DROP INDEX index_platforms_on_lowercase_name;"
  end
end
