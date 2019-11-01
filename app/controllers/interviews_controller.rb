class InterviewsController < ApplicationController
  before_action :set_interview, only: %i[accept reject]
  before_action :authenticate_candidate!, only: %i[accept reject]

  def accept
    return unless @interview.pending?

    @interview.scheduled!
    send_message('scheduled')
    InterviewMailer.interview_accepted(@interview.id).deliver_now
    redirect_to selection_process_candidates_path(@interview.selection_process)
  end

  def reject
    return unless @interview.pending?

    @interview.canceled!
    send_message('canceled')
    redirect_to selection_process_candidates_path(@interview.selection_process)
  end

  private

  def set_interview
    @interview = Interview.find(params[:id])
  end

  def send_message(message_type)
    @interview.selection_process.messages
              .create(text: I18n.t('interview.status_badge.' + message_type) +
              ': ' + I18n.l(@interview.date, format: :long),
                      sendable: current_candidate,
                      message_type: ('interview_' + message_type).to_sym)
  end
end
