class CompaniesController < ApplicationController
  before_action :set_company, only: [:edit]
  def edit; end

  def update; end

  private

  def set_company
    @company = Company.find(params[:id])
  end
end
