class EmployeeSerializer < ActiveModel::Serializer
  attributes :emp_id, :first_name, :last_name, :email, :date_of_join, :salary, :caluclate_tax, :cess_tax, :incomplete_month_calculation, :incomplete_month_salary, :joined_month_caluclation, :anual_salary
end
