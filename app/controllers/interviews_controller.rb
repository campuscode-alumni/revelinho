class InterviewsController < ApplicationController
  before_action :set_interview, only: %i[accept reject]
  before_action :authenticate_candidate!, only: %i[accept reject]

  def accept
    @interview.scheduled!
    redirect_to selection_process_candidates_path(@interview.selection_process)
  end

  def reject
    @interview.canceled!
    redirect_to selection_process_candidates_path(@interview.selection_process)
  end

  private

  def set_interview
    @interview = Interview.find(params[:id])
  end
end
