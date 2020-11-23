class AddUserToDoctors < ActiveRecord::Migration[6.0]
  def change
    add_reference :doctors, :user, null: true, index: true
  end
end
