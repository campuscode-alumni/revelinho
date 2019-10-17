class HomeController < ApplicationController
  def index
    redirect_to dashboard_candidates_path if candidate_signed_in?
    # elsif employee_signed_in?
    # redirect_to employee_candidates_path
    # end
  end
end
