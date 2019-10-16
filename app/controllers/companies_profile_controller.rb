class CompaniesProfileController < ApplicationController
  before_action :set_company_profile, only: %i[edit update]

  def edit; end

  def update
    if @company_profile.update(company_profile_params)
      redirect_to @company_profile
    else
      render :edit
    end
  end

  private

  def company_profile_params
    params.require(:company_profile).permit(:full_description, :benefits, :logo)
  end

  def set_company_profile
    @companies_profile = CompanyProfile.find(params[:id])
  end
end
