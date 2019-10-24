class CompanyProfilesController < ApplicationController
  before_action :authenticate_employee!, only: %i[new create]
  before_action :set_company_profile, only: %i[edit update]
  before_action :own_company_profile, only: %i[edit update]

  def new
    @company_profile = CompanyProfile.new
  end

  def create
    create_current_employee.save
    redirect_to current_employee.company,
                notice: I18n.t('company_profile.create.success')
    respond_to do |format|
      format.html { byebug }
      format.js { byebug  }
    end
  end

  def edit
  end

  def update
    current_employee.company.company_profile.update(company_profile_params)
    respond_to do |format|
      format.html { byebug }
      format.js
    end
  end

  private

  def create_current_employee
    current_employee.company.build_company_profile(company_profile_params)
  end

  def company_profile_params
    params.require(:company_profile).permit(:full_description, :benefits, :logo,
                                            :employees_number, :website, :phone,
                                            :mission, :category, :attractives)
  end

  def set_company_profile
    @company_profile = CompanyProfile.find(params[:id])
  end

  def own_company_profile
    return redirect_to dashboard_companies_path unless
    current_employee.company.company_profile == @company_profile
  end
end
