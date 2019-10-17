class CompaniesController < ApplicationController
  before_action :authenticate_employee!, only: %i[index edit show]
  before_action :set_company, only: %i[edit update show]
  before_action :own_company, only: %i[edit update show]

  def index
    @company = current_employee.company
  end

  def edit; end

  def update
    redirect_to company_path(@company) if @company.update(company_params)
  end

  def show
    @company_profile = @company.company_profile
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :address)
  end

  def own_company
    redirect_to root_path unless current_employee.company == @company
  end
end
