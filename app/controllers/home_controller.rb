class HomeController < ApplicationController
  def index
    redirect_to dashboard_candidates_path if candidate_signed_in?
  end
end
