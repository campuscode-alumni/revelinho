class InterviewsController < ApplicationController
  before_action :set_interview, only: %i[accept reject]
  before_action :authenticate_candidate!, only: %i[accept reject]

  def accept
    return unless @interview.pending?

    @interview.scheduled!
    message_accepted
    InterviewMailer.interview_accepted(@interview.id).deliver_now
    redirect_to selection_process_candidates_path(@interview.selection_process)
  end

  def reject
    return unless @interview.pending?

    @interview.canceled!
    message_rejected
    redirect_to selection_process_candidates_path(@interview.selection_process)
  end

  private

  def set_interview
    @interview = Interview.find(params[:id])
  end

  def message_accepted
    @interview.selection_process.messages
              .create(text: I18n.t('interview.status_badge.scheduled') +
              ': ' + I18n.l(@interview.date, format: :long),
                      sendable: current_candidate,
                      message_type: :interview_accepted)
  end

  def message_rejected
    @interview.selection_process.messages
              .create(text: I18n.t('interview.status_badge.rejected') +
              ': ' + I18n.l(@interview.date, format: :long),
                      sendable: current_candidate,
                      message_type: :interview_rejected)
  end
end
