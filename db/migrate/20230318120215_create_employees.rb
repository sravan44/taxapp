class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :emp_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.date :date_of_join
      t.decimal :salary, :precision => 10, :scale => 2

      t.timestamps
    end
  end
end
