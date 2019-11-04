class CompaniesController < ApplicationController
  before_action :authenticate_employee!, only: %i[index edit update dashboard]
  before_action :set_company, only: %i[edit update show]
  before_action :set_company_profile, only: %i[show]
  before_action :set_current_company, only: %i[edit update show
                                               dashboard invites
                                               selection_processes]
  before_action :own_company, only: %i[edit update show]
  before_action :employee_pending, except: %i[edit update]

  def index; end

  def edit; end

  def update
    if @company.update(company_params)
      @company.active!
      redirect_to dashboard_companies_path
    else
      render :edit
    end
  end

  def show; end

  def dashboard
    @dashboard = CompanyProfileDecorator.decorate(@current_company)
  end

  def selection_processes
    @selection_processes = CompanySelectionProcessesQuery
                           .new(@current_company).all
  end

  def invites
    @invites = InvitePresenter
               .decorate_collection(current_employee.company.invites,
                                    current_employee)
  end

  private

  def set_current_company
    @current_company = current_employee.company
  end

  def set_company_profile
    @company_profile = @company.company_profile
  end

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :address)
  end

  def own_company
    redirect_to company_path(@current_company) if
    @current_company != @company
  end

  def employee_pending
    employee = current_employee
    return redirect_to edit_company_path(employee.company) if
    employee_signed_in? && employee.company.pending?
  end
end
