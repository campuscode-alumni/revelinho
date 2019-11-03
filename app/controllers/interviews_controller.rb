class InterviewsController < ApplicationController
  before_action :authenticate_employee!, only: %i[index new create]
  before_action :parametize, only: %i[new create update]
  before_action :parametize_interview, only: %i[create update]
  before_action :authorize_employee!, only: %i[create update]
  before_action :set_interview, only: %i[accept reject]
  before_action :authenticate_candidate!, only: %i[accept reject]

  def index
    if employee_signed_in?
      render json: current_employee.company.interviews
    else
      render json: {}, status: :forbidden
    end
  end

  def new
    @candidate = @selection_process.candidate.to_json
    @position = @selection_process.position.to_json
    @formats_json = { formats: Interview.formats.map do |value, _i|
      { name: I18n.t(:"interview.format.#{value}"),
        value: value }
    end }.to_json
    @url = selection_process_interviews_path(@selection_process)
  end

  def create
    @interview = Interview.new(@interview_params)
    if @interview.save
      render json: @interview,
             status: :created
    else
      render json: @interview.errors, status: :unprocessable_entity
    end
  end

  def update
    interview = Interview.find(params[:id])
    if interview.update(@interview_params)
      render json: interview, status: :ok
    else
      render json: interview.errors, status: :bad_request
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

  def parametize_interview
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
