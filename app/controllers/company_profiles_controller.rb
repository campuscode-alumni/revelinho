class CompanyProfilesController < ApplicationController
  before_action :authenticate_employee!, only: %i[new create]
  before_action :create_current_employee, only: %i[create]

  def new
    @company_profile = CompanyProfile.new
  end

  def create
    if current_employee.company.company_profile.save
      flash[:notice] = 'O perfil da empresa foi atualizado com sucesso.'
      redirect_to current_employee.company
    end
  end

  private

  def create_current_employee
    current_employee.company.company_profile =
      CompanyProfile.new(company_profile_params)
  end

  def company_profile_params
    params.require(:company_profile).permit(:full_description, :benefits, :logo,
      :employees_number, :website, :phone, :mission, :category, :attractives)
  end
end
