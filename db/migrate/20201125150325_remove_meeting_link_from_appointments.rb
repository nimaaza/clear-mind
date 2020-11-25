class RemoveMeetingLinkFromAppointments < ActiveRecord::Migration[6.0]
  def change
    remove_column :appointments, :meeting_link
    remove_column :appointments, :status
  end
end
