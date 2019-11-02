class InterviewsController < ApplicationController
  before_action :authenticate_employee!, only: %i[new create]
  before_action :parametize, only: %i[new create]
  before_action :parametize_create, only: %i[create]
  before_action :authorize_employee!, only: %i[create]
  before_action :set_interview, only: %i[accept reject]
  before_action :authenticate_candidate!, only: %i[accept reject]

  def new
    @formats_json = { formats: Interview.formats.map do |value, _i|
      { name: I18n.t(:"activerecord.attributes.interview.format.#{value}"),
        value: value }
    end }.to_json
    @post_url = selection_process_interviews_path(@selection_process)
  end

  def create
    @interview = Interview.new(@interview_params)
    respond_to do |format|
      if @interview.save
        format.json { render json: @interview, status: :created }
      else
        format.json do
          render json: @interview.errors, status: :unprocessable_entity
        end
      end
    end
  end

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

  def parametize
    @selection_process = SelectionProcess.find(params[:selection_process_id])
    @position = @selection_process.invite.position
    @candidate = @selection_process.invite.candidate
  end

  def parametize_create
    @interview_params = params.require(:interview).permit(:date, :time_to,
                                                          :time_from, :address,
                                                          :format)
    @interview_params[:selection_process_id] = params[:selection_process_id]
  end

  def authorize_employee!
    return if @selection_process.invite.position.company ==
              current_employee.company

    render json: {}, status: :forbidden
  end

  def set_interview
    @interview = Interview.find(params[:id])
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
