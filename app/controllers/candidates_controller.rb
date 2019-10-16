class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:show]

  def index
    @candidates = Candidate.published
    msg = 'Não há candidatos cadastrados até agora'
    flash[:notice] = msg if @candidates.empty?
  end

  def show; end

  def dashboard; end

  private

  def set_candidate
    @candidate = Candidate.find(params[:id])
  end
end
