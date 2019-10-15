class CompaniesController < ApplicationController
  before_action :set_company, only: %i[edit update show]
  def edit; end
  
  def update
    if @company.update(company_params)
      redirect_to company_path(@company)
    end
  end

  def show; end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :address)
  end
end