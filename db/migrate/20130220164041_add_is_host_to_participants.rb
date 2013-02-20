class AddIsHostToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :is_host, :boolean
  end
end
