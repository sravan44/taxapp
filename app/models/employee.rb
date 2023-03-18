class Employee < ApplicationRecord
  include ActiveModel::Serialization

  validates :first_name,    presence: true
  validates :last_name,     presence: true
  validates :emp_id,        presence: true
  validates :email,         presence: true
  validates :date_of_join,  presence: true
  validates :salary,        presence: true

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

  def tax_amount

    total_salary = (incomplete_month_salary + joined_month_caluclation-1)*joined_month_caluclation

    @taxable_total = 0

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

  def incomplete_month_salary
    salary*incomplete_month_calculation
  end

  def incomplete_month_calculation
    if first_date_of_month?
      1
    else
      fraction_part_of_month
    end
  end

  def first_date_of_month?
    @start_date == date_of_join.at_beginning_of_month
  end

  def fraction_part_of_month
    work_days_in_this_month = date_of_join.at_end_of_month.day
    worked_days = work_days_in_this_month - date_of_join.day
    worked_days.to_f / work_days_in_this_month.to_f
  end

  def anual_salary
    (salary*joined_month_caluclation) + incomplete_month_salary
  end

  def cess_tax
    if anual_salary>2500000
      anual_salary - (2500000 * 2)/100
    else
      0
    end
  end

end
