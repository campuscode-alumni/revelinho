class HomeController < ApplicationController
  before_action :redirect_dashboard, only: [:index]

  def index; end

  private

  def redirect_dashboard
    return redirect_to dashboard_candidates_path if candidate_signed_in?
    return redirect_to dashboard_companies_path if employee_signed_in?
  end
end
