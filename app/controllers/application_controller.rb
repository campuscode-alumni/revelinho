class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    return dashboard_candidates_path unless resource.is_a? Employee
    return company_path(resource.company) unless resource.company.pending?

    flash[:notice] = 'Preencha os dados corretamente'
    edit_company_path(resource.company)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[name cpf birthday occupation phone educational_level
               address city state country zip_code]
    )
  end
end
