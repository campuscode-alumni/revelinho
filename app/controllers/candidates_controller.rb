class CandidatesController < ApplicationController
  before_action :authenticate_employee!, only: %i[invite]
  before_action :set_candidate, only: %i[show invite]
  before_action :invite_params, only: %i[invite]
  before_action :authorize_employee, only: %i[invite]

  def index
    @candidates = Candidate.published
    msg = 'Não há candidatos cadastrados até agora'
    flash[:notice] = msg if @candidates.empty?
  end

  def show
    return redirect_to candidates_path unless @candidate.published?
    return unless employee_signed_in?

    current_company_id = current_employee.company.id
    @notes = Company.select('candidate_notes.id, ' \
      'employees.email as employee_email, ' \
      'candidate_notes.comment').joins(employees: :candidate_notes).where(
        id: current_company_id
      )
    @positions = @candidate.uninvited_positions(current_employee.company)
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

  def dashboard; end

  def invite
    invite = @candidate.invites.new(@invite_params)
    if invite.save
      flash[:success] = "#{@candidate.name} convidado com sucesso para " \
      "#{@position.title}"
      redirect_to candidates_path
    else
      flash[:alert] = 'Erro ao tentar convidar candidato'
      redirect_to @candidate
    end
  end

  private

  def authorize_employee
    return unless current_employee.company.id != @position.company.id

    raise ActionController::UnpermittedParameters.new(
      status: 'Employee unauthorized'
    )
  end

  def invite_params
    @invite_params = params.permit(:position_id, :message)
    @position = Position.find(@invite_params[:position_id])
  end

  def set_candidate
    @candidate = Candidate.find(params[:id])
  end
end
