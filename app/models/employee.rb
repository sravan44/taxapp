class Employee < ApplicationRecord
  validates :first_name,    presence: true
  validates :last_name,     presence: true
  validates :emp_id,        presence: true
  validates :email,         presence: true
  validates :date_of_join,  presence: true
  validates :salary,        presence: true
end
