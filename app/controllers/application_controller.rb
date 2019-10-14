class ApplicationController < ActionController::Base
  protected
  
  def after_sign_up_path_for(resource)
    edit_company_path(Company.last)
  end
end
