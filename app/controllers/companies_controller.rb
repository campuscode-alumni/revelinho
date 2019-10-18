class CompaniesController < ApplicationController
  before_action :authenticate_employee!, only: %i[index edit update show]
  before_action :set_company, only: %i[edit update show]
  before_action :own_company, only: %i[edit update show]
  before_action :employee_pending, except: %i[edit update]

  def index; end

  def edit; end

  def update
    return unless @company.update(company_params)

    @company.active!
    redirect_to company_path(@company)
  end

  def show
    @company_profile = @company.company_profile
  end

  def dashboard; end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :address)
  end

  def own_company
    redirect_to company_path(current_employee.company) unless
    current_employee.company == @company
  end

  def employee_pending
    employee = current_employee
    return redirect_to edit_company_path(employee.company) if
    employee_signed_in? && employee.company.pending?
  end
end
