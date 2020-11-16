class AddAboutToDoctors < ActiveRecord::Migration[6.0]
  def change
    add_column :doctors, :about, :text
  end
end
