class InterviewsController < ApplicationController
  def new
    @interview = Interview.new
    @selection_process = SelectionProcess.find(params[:selection_process_id])
    @position = @selection_process.invite.position
    @candidate = @selection_process.invite.candidate
  end

  def create
    interview_params = params.permit(%i[date hour minutes address format
                                        selection_process_id])
    interview = Interview.new(interview_params)
    datetime_text = interview_params[:date] + ' ' + interview_params[:hour] + ':' + interview_params[:minutes]
    interview.datetime = DateTime.parse(datetime_text)

    if interview.save
      flash[:notice] = 'Solicitação enviada. Aguardando confirmação do candidato'
      redirect_to selection_process_path(interview_params[:selection_process_id])
    else
      flash.now[:danger] = '...'
      render :new
    end
  end
end
