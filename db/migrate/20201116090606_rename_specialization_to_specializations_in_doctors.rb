class RenameSpecializationToSpecializationsInDoctors < ActiveRecord::Migration[6.0]
  def change
    rename_column :doctors, :specialization, :specializations
  end
end
