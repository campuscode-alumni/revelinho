class CandidatesController < ApplicationController
  before_action :redirect_candidate_dashboard, only: [:index]
  before_action :authenticate_candidate!, only: %i[invites dashboard]
  before_action :authenticate_employee!, only: %i[invite index]
  before_action :candidate, only: %i[show invite]
  before_action :set_invite, only: %i[accept_invite reject_invite]
  before_action :set_candidates_list, only: %i[index]
  before_action :decorate_list, only: %i[index]
  before_action :decorate, only: %i[show]
  before_action :invite_params, only: %i[invite]
  before_action :owner_invite, only: %i[accept_invite reject_invite]

  def index
    msg = 'Não há candidatos cadastrados até agora'
    flash[:notice] = msg if @candidates.empty?
  end

  def show
    return redirect_to candidates_path unless @candidate.published?
    return unless employee_signed_in?

    @notes = CandidateNote.includes(:employee).where(
      employees: { company: current_employee.company },
      candidate_id: @candidate.id
    ).decorate
    @positions = @employee_candidate_presenter.uninvited_positions
  end

  def add_comment
    candidate_note = CandidateNote.new(
      comment: params.require(:comment),
      employee: current_employee
    )
    candidate = Candidate.find(params[:id])
    candidate.candidate_notes << candidate_note
    redirect_to candidate
  end

  def dashboard
    @dashboard = CandidateDashboardDecorator.decorate(current_candidate)
  end

  def invite
    invite = @candidate.invites.new(@invite_params) do |i|
      i.employee = current_employee
    end

    if invite.save
      flash[:success] = "#{@candidate.name} convidado com sucesso para " \
      "#{@position.title}"
      return redirect_to candidates_path
    end
    flash[:danger] = 'Erro ao tentar convidar candidato'
    redirect_to @candidate
  end

  def invites
    @invites = current_candidate.invites.decorate
  end

  def accept_invite
    @invite.selection_process = SelectionProcess.new
    return redirect_to invites_candidates_path unless
      @invite.selection_process.save

    @invite.accepted!

    redirect_to selection_process_candidates_path(@invite.selection_process)
  end

  def reject_invite
    @invite.rejected!
  end

  private

  def candidate
    @candidate ||= Candidate.find(params[:id])
  end

  def set_invite
    @invite = Invite.find(params[:id])
  end

  def set_candidates_list
    @candidates = Candidate.published
  end

  def decorate_list
    @employee_candidate_presenters =
      EmployeeCandidatePresenter.decorate_collection(
        @candidates, current_employee
      )
  end

  def decorate
    @employee_candidate_presenter =
      EmployeeCandidatePresenter.new(@candidate, current_employee)
  end

  def invite_params
    @invite_params = params.permit(:position_id, :message)
    @position = current_employee.company.positions.find(
      @invite_params[:position_id]
    )
  end

  def owner_invite
    return redirect_to invites_candidates_path unless
     current_candidate.invites.where(id: @invite.id, status: :pending).any?
  end

  def redirect_candidate_dashboard
    redirect_to dashboard_candidates_path if candidate_signed_in?
  end
end
