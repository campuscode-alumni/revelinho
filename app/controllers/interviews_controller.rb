class InterviewsController < ApplicationController
  before_action :authenticate_employee!, only: %i[new create]
  before_action :parametize, only: %i[new create]
  before_action :authorize_employee!, only: %i[create]

  def new
    @interview = Interview.new
  end

  def create
    interview_params = params.permit(:date, :time_to, :time_from, :address,
                                     :format, :selection_process_id)
    @interview = Interview.new(interview_params)
    @interview.time_from = interview_params[:time_from] + ':00'
    @interview.time_to = interview_params[:time_to] + ':00'

    if @interview.save     
      flash[:notice] = 'Solicitação enviada. Aguardando confirmação do candidato'
      redirect_to selection_process_path(interview_params[:selection_process_id])
    else
      flash.now[:danger] = 'Preencha todos os campos corretamente'
      render :new
    end
  end

  private

  def parametize
    @selection_process = SelectionProcess.find(params[:selection_process_id])
    @position = @selection_process.invite.position
    @candidate = @selection_process.invite.candidate
  end

  def authorize_employee!
    return if @selection_process.invite.position.company ==
              current_employee.company
    
    render json: {}, status: :forbidden
  end
end
