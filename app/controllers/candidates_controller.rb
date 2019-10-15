class CandidatesController < ApplicationController
  def show
    @candidate = Candidate.find(params[:id])
    @notes = @candidate.candidate_notes
  end
end
