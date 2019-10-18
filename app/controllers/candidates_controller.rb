class CandidatesController < ApplicationController
  before_action :authenticate_candidate!, only: [:invites]
  before_action :set_candidate, only: [:show]
  before_action :set_invite, only: %i[accept_invite reject_invite]
  before_action :own_invite, only: %i[accept_invite reject_invite]

  def index
    @candidates = Candidate.published
    msg = 'Não há candidatos cadastrados até agora'
    flash[:notice] = msg if @candidates.empty?
  end

  def show
    return redirect_to candidates_path unless @candidate.published?
    return unless employee_signed_in?

    @notes = Company.select('candidate_notes.id, ' \
      'employees.email as employee_email, ' \
      'candidate_notes.comment').joins(employees: :candidate_notes).where(
        id: current_employee.company.id
      )
  end

  def add_comment
    candidate_note = CandidateNote.new(
      comment: params.require(:comment),
      employee: current_employee
    )
    candidate = Candidate.find(params[:candidate_id])
    candidate.candidate_notes << candidate_note
    redirect_to candidate
  end

  def dashboard; end

  def invites
    @invites = current_candidate.invites.pending
  end

  def accept_invite
    return redirect_to invites_candidates_path unless
     SelectionProcess.create(invite: @invite)

    @invite.accepted!

    redirect_to selection_process_candidates_path(@invite.selection_process)
  end

  def reject_invite
    @invite.rejected!
  end

  private

  def set_candidate
    @candidate = Candidate.find(params[:id])
  end

  def set_invite
    @invite = Invite.find(params[:id])
  end

  def own_invite
    return redirect_to invites_candidates_path unless
     current_candidate.invites.include? @invite
  end
end
