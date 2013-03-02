class RemoveHostIdFromNewParticipantNotification < ActiveRecord::Migration
  def up
    remove_column :new_participant_notifications, :host_id
  end

  def down
    add_column :new_participant_notifications, :host_id, :integer
  end
end
