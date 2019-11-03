class InterviewsController < ApplicationController
  before_action :authenticate_candidate!, only: %i[accept reject]
  before_action :authenticate_employee!, only: %i[status]
  before_action :interview, only: %i[accept reject status]

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

  def status
    @interview.send("#{params[:status]}!")
    redirect_to selection_process_candidates_path(@interview.selection_process)
  end

  private

  def interview
    @interview ||= Interview.find(params[:id])
  end

  def send_message(message_type)
    text = I18n.t('interview.status_badge.' + message_type) + ': ' +
           I18n.l(@interview.date, format: :long)
    message_type = ('interview_' + message_type).to_sym

    @interview.selection_process.messages
              .create(text: text,
                      sendable: current_candidate,
                      message_type: message_type)
  end
end
