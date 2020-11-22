class AddSessionIdToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :session_id, :string
  end
end
