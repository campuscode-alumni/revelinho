class CompaniesController < ApplicationController
  before_action :authenticate_employee!, only: [:edit, :show]
  before_action :set_company, only: [:edit, :update, :show]
  before_action :own_company, only: [:edit, :update, :show]

  def edit; end

  def update
    redirect_to company_path(@company) if @company.update(company_params)
  end

  def show; end

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
