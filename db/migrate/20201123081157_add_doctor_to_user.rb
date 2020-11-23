class AddDoctorToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :doctor, null: true, default: :null, index: true
  end
end
