class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(resource)
    return super unless resource.is_a? Employee

    # return super  resource.company.blank?
    flash[:notice] = 'Preencha os dados corretamente'
    edit_company_path(resource.company)
  end
end
