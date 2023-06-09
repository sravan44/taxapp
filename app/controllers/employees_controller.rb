class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy]

  # GET /employees
  def index
    @employees = Employee.allbundle

    render json: {
      data: ActiveModelSerializers::SerializableResource.new(@employees, each_serializer: EmployeeSerializer),
      message: ['Employee list fetched successfully'],
      status: 200,
      type: 'Success'
    }
  end

  # GET /employees/1
  def show
    render json: {
      data: ActiveModelSerializers::SerializableResource.new(@employee, each_serializer: EmployeeSerializer),
      message: ['Employee details fetched successfully'],
      status: 200,
      type: 'Success'
    }
  end

  # POST /employees
  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      render json: @employee, status: :created, location: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /employees/1
  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # DELETE /employees/1
  def destroy
    @employee.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_params
      params.require(:employee).permit(:emp_id, :first_name, :last_name, :email, :date_of_join, :salary, :phone_numbers)
    end
end
