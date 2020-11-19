class AddDateTimeToAppointments < ActiveRecord::Migration[6.0]
  def change
    remove_column :appointments, :appointment_start
    remove_column :appointments, :appointment_end
    add_column :appointments, :appointment_start, :datetime
    add_column :appointments, :appointment_end, :datetime
  end
end
