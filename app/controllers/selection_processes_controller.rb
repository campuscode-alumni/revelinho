class SelectionProcessesController < ApplicationController
  before_action :set_selection_process, only: %i[show send_message]
  before_action :authenticate_users!, only: %i[show send_message]
  before_action :decorate_interview, only: %i[show]

  def show
    redirect_to dashboard_companies_path unless belongs_here?
  end

  def send_message
    message = @selection_process.messages.create(params.permit(:text)) do |m|
      m.sendable = current_user
    end

    flash[:notice] = 'Não foi possivel enviar mensagem. Tente novamente' if
     message.errors.any?

    redirect_to selection_process_candidates_path(@selection_process)
  end

  private

  def decorate_interview
    # user = current_candidate || current_employee
    # @interviews = InterviewDecorator.decorate_collection(
    #   @selection_process.interviews.order(id: :desc), user
    # )
    @interviews = @selection_process.interviews.order(id: :desc).decorate
  end

  def set_selection_process
    @selection_process = SelectionProcess.find(params[:id]).decorate
  end

  def belongs_here?
    current_candidate || (current_employee &&
      @selection_process.company.name == current_employee.company.name)
  end
end
