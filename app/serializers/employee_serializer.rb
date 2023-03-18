# Active record Serializer for displaying the attribute
# Included serializer So that if we want we can change the attributes

class EmployeeSerializer < ActiveModel::Serializer
  attributes :emp_code, :first_name, :last_name, :email, :date_of_join, :salary, :tax_amount, 
             :cess_tax, :incomplete_month_calculation, :incomplete_month_salary, :joined_month_caluclation, 
             :anual_salary

  def emp_code
    object.emp_id
  end
end
