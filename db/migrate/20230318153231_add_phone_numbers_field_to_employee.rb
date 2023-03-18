class AddPhoneNumbersFieldToEmployee < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :phone_numbers, :text, array: true, default: []
  end
end
