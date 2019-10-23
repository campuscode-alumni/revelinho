class CandidatesController < ApplicationController
  require "time"
  before_action :authenticate_candidate!, only: %i[invites dashboard]
  before_action :authenticate_employee!, only: %i[invite]
  before_action :candidate, only: %i[show invite]
  before_action :set_invite, only: %i[accept_invite reject_invite]
  before_action :set_candidates_list, only: %i[index]
  before_action :decorate_list, only: %i[index]
  before_action :decorate, only: %i[show]
  before_action :invite_params, only: %i[invite]
  before_action :owner_invite, only: %i[accept_invite reject_invite]
  before_action :authorize_employee, only: %i[invite]

  def index
    msg = 'Não há candidatos cadastrados até agora'
    flash[:notice] = msg if @candidates.empty?
  end

  def show
    return redirect_to candidates_path unless @candidate.published?
    return unless employee_signed_in?

    @notes = CandidateNote.includes(employee: :company).where(
      employees: { company: current_employee.company }
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
    invite = @candidate.invites.new(@invite_params)
    if invite.save
      flash[:success] = "#{@candidate.name} convidado com sucesso para " \
      "#{@position.title}"
      redirect_to candidates_path
    else
      flash[:danger] = 'Erro ao tentar convidar candidato'
      redirect_to @candidate
    end
  end

  def invites
    @invites = current_candidate.invites
    @invite_presenter = InvitePresenter.new
  end

  def accept_invite
    @invite.accepted_or_rejected_at = Date.current
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

  def authorize_employee
    return if current_employee.company.id == @position.company.id

    raise ActionController::UnpermittedParameters.new(
      status: 'Employee unauthorized'
    )
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
end
