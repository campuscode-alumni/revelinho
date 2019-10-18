class SelectionProcessesController < ApplicationController
  before_action :set_selection_process, only: [:show, :send_message]

  def show; end

  def send_message
    
  end

  private

  def set_selection_process
    @selection_process = SelectionProcess.find(params[:id])
  end
end
