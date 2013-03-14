class AddHashTagToGames < ActiveRecord::Migration
  def change
    add_column :games, :hashtag, :string
  end
end
