class DropVacanciesTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :vacancies
  end
end
