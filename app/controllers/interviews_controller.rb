class InterviewsController < ApplicationController
  before_action :authenticate_candidate!, only: %i[accept reject]
  before_action :authenticate_employee!, only: %i[status]
  before_action :interview, only: %i[accept reject status]

  def accept
    return unless @interview.pending?

    @interview.scheduled!
    InterviewMailer.interview_accepted(@interview.id).deliver_now
    redirect_to selection_process_candidates_path(@interview.selection_process)
  end

  def reject
    return unless @interview.pending?

    @interview.canceled!
    redirect_to selection_process_candidates_path(@interview.selection_process)
  end

  def status
    byebug
  end

  private

  def interview
    @interview ||= Interview.find(params[:id])
  end
end
