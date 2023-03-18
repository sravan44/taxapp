##Emplyees Model with active record 
# Attributes :: emp_id ##Employee Code
# Attributes :: first_name
# Attributes :: last_name
# Attributes :: email
# Attributes :: date_of_join # dd
# Attributes :: salary ## Decimal

class Employee < ApplicationRecord
  include ActiveModel::Serialization

  ## Validations
  validates :first_name,    presence: true
  validates :last_name,     presence: true
  validates :emp_id,        presence: true, uniqueness: true
  validates :email,         presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :date_of_join,  presence: true
  validates :salary,        presence: true
  validates :phone_numbers, presence: true

  # From Date of join caluclating the number of months in present Tax Year
  def joined_month_caluclation
    joined_month = date_of_join.month 
    if joined_month <= 3
      joined_month-3
    else
      if joined_month > 4
        12 - joined_month
      else
        12
      end
    end
  end

  #Caluclatint the total Tax Amount Including Cess
  def tax_amount
    total_salary = (incomplete_month_salary + joined_month_caluclation-1)*joined_month_caluclation

    @taxable_total = 0

    # Logic For Tax caluclation as per the given condition
    if total_salary > 250000
      if total_salary >1000000
        @taxable_total += (total_salary - 1000000)*20/100
        @taxable_total += 12500 + 50000
      elsif total_salary <1000000 && total_salary > 500000
        @taxable_total += (total_salary - 500000)*10/100
        @taxable_total += 12500
      else
        @taxable_total =  (total_salary - 250000)*5/100
      end
    end

    @taxable_total + cess_tax
  end

  #Salary for the incomplete month
  def incomplete_month_salary
    salary*incomplete_month_calculation
  end

  # Get the Fraction for caluclation of incomplete months salay
  def incomplete_month_calculation
    if date_of_join.at_beginning_of_month
      1
    else
      fraction_part_of_month
    end
  end

  # Caluclating fraction i.e Total billable days / Total days in a month
  def fraction_part_of_month
    work_days_in_this_month = date_of_join.at_end_of_month.day
    worked_days = work_days_in_this_month - date_of_join.day
    worked_days.to_f / work_days_in_this_month.to_f
  end

  #Anual Salary of Employee After Joinging 
  def anual_salary
    (salary*joined_month_caluclation) + incomplete_month_salary
  end

  #Caluclating Cess Tax
  def cess_tax
    if anual_salary>2500000
      anual_salary - (2500000 * 2)/100
    else
      0
    end
  end

end
