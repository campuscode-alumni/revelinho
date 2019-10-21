class CompanyProfilesController < ApplicationController
  before_action :authenticate_employee!, only: %i[new create]
  before_action :create_current_employee, only: %i[create]

  def new
    @company_profile = CompanyProfile.new
  end

  def create
    return unless current_employee.company.company_profile.save

    redirect_to current_employee.company,
                notice: I18n.t('company_profile.create.success')
  end

  private

  def create_current_employee
    current_employee.company.company_profile =
      CompanyProfile.new(company_profile_params)
  end

  def company_profile_params
    params.require(:company_profile).permit(:full_description, :benefits, :logo,
                                            :employees_number, :website, :phone,
                                            :mission, :category, :attractives)
  end
end