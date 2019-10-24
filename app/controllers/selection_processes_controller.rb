class SelectionProcessesController < ApplicationController
  before_action :set_selection_process, only: %i[show send_message]
  before_action :authenticate_users!, only: %i[show send_message]

  def show; end

  def send_message
    message = @selection_process.messages.create(params.permit(:text)) do |m|
      m.sendable = current_user
    end

    flash[:notice] = 'Não foi possivel enviar mensagem. Tente novamente' if
     message.errors.any?

    redirect_to selection_process_candidates_path(@selection_process)
  end

  private

  def set_selection_process
    @selection_process = SelectionProcess.find(params[:id]).decorate
  end
end
