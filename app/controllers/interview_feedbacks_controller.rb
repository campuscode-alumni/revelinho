class InterviewFeedbacksController < ApplicationController
  before_action :interview, only: %i[index send_feedback]
  def index; end

  def send_feedback
    feedback = @interview.interview_feedbacks.create(
      message: params[:text]
    ) do |m|
      m.employee = current_employee
    end

    flash[:notice] = 'Não foi possivel enviar feedback. Tente novamente' if
     feedback.errors.any?

    redirect_to interview_feedback_candidates_path
  end

  private

  def interview
    @interview ||= Interview.find(params[:id])
  end
end
