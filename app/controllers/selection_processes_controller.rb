class SelectionProcessesController < ApplicationController
  before_action :set_selection_process, only: %i[show send_message]

  def show; end

  def send_message
    message = @selection_process.messages.new(params.permit(:text))
    message.sendable = current_user

    flash[:notice] = 'Não foi possivel enviar mensagem. Tente novamente' unless
     message.save

    redirect_to selection_process_candidates_path(@selection_process)
  end

  private

  def set_selection_process
    @selection_process = SelectionProcess.find(params[:id])
  end
end
