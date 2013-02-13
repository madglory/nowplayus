class AddDeletedAtColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :deleted_at, :datetime
  end
end
