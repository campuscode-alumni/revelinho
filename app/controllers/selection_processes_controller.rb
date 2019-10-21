class SelectionProcessesController < ApplicationController
  before_action :set_selection_process, only: %i[show send_message]

  def show; end

  def send_message
    message = Message.new(params.permit(:text))
    message.sendable = current
    flash[:notice] = 'Não foi possivel enviar mensagem' unless
    @selection_process.messages << message

    redirect_to selection_process_candidates_path(@selection_process)
  end

  private

  def set_selection_process
    @selection_process = SelectionProcess.find(params[:id])
  end
end
