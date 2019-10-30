class CompaniesController < ApplicationController
  before_action :authenticate_employee!, only: %i[index edit update show
                                                  dashboard]
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
      redirect_to company_path(@company)
    else
      render :edit
    end
  end

  def show; end

  def dashboard
    @dashboard = CompanyProfileDecorator.decorate(@current_company)
  end

  def invites
    @company_invites_presenter = CompanyInvitesPresenter.new(@current_company)
    @invites = @company_invites_presenter.invites
  end

  def selection_processes
    @selection_processes_presenter = CompanySelectionProcessesPresenter
                                     .new(@current_company)
    @selection_processes = @selection_processes_presenter.selection_processes
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
    redirect_to company_path(@current_company) unless
    @current_company == @company
  end

  def employee_pending
    employee = current_employee
    return redirect_to edit_company_path(employee.company) if
    employee_signed_in? && employee.company.pending?
  end
end
