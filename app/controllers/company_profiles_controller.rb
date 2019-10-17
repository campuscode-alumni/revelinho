class CompanyProfilesController < ApplicationController
  before_action :authenticate_employee!, only: %i[new create]
  before_action :create_current_employee, only: %i[create]

  def new
    @company_profile = CompanyProfile.new
  end

  def create
    if current_employee.company.company_profile.save
      current_employee.company.active!
      flash[:notice] = 'O perfil da empresa foi atualizado com sucesso.'
      redirect_to current_employee.company
    else
      flash[:notice] = 'Erro ao atualizar o perfil da empresa.'
      render :new
    end
  end

  private

  def create_current_employee
    current_employee.company.company_profile =
      CompanyProfile.new(company_profile_params)
  end

  def company_profile_params
    params.require(:company_profile).permit(:full_description, :benefits, :logo)
  end

  def set_company_profile
    @company_profile = CompanyProfile.find(params[:id])
  end
end
