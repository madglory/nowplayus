class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :giantbomb_id
      t.string  :name
      t.text    :deck
      t.text    :description

      t.string :original_game_rating

      t.datetime :date_added
      t.datetime :original_release_date

      t.string :icon_url
      t.string :medium_url
      t.string :screen_url

      t.string :small_url
      t.string :super_url
      t.string :thumb_url
      t.string :tiny_url

      t.timestamps
    end

    add_index :games, :giantbomb_id, :unique => true
    add_index :games, :name
  end
end
