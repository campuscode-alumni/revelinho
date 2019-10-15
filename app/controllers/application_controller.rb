class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    return super unless resource.is_a? Employee

    # return super  resource.company.blank?
    flash[:notice] = 'Preencha os dados corretamente'
    edit_company_path(resource.company)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name cpf birthday
                                                      occupation phone
                                                      educational_level
                                                      address])
  end
end
