class HomeController < ApplicationController
  def index
    if candidate_signed_in?
      redirect_to dashboard_candidates_path
    elsif employee_signed_in?
      redirect_to dashboard_companies_path
    end
  end
end
