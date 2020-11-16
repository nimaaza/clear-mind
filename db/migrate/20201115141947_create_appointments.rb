class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :doctor, null: false, foreign_key: true
      t.boolean :status
      t.string :meeting_link
      t.date :appointment_start
      t.date :appointment_end

      t.timestamps
    end
  end
end
