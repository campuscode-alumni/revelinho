class CompanyProfilesController < ApplicationController
  before_action :set_company_profile, only: %i[edit update]

  def edit; end

  def update
    if @company_profile.update(company_profile_params)
      current_employee.company.active!
      msg = 'O perfil da empresa foi atualizado com sucesso. '\
            'Agora você pode cadastrar vagas.'
      flash[:notice] = msg
      redirect_to current_employee.company
    else
      render :edit
    end
  end

  private

  def company_profile_params
    params.require(:company_profile).permit(:full_description, :benefits, :logo)
  end

  def set_company_profile
    @company_profile = CompanyProfile.find(params[:id])
  end
end
