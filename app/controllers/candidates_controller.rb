class CandidatesController < ApplicationController
  def show
    @candidate = Candidate.find(params[:id])
    @notes = Company.select('candidate_notes.id, ' \
      'employees.email as employee_email, ' \
      'candidate_notes.comment').joins(employees: :candidate_notes).where(
        id: current_employee.company.id
      )
  end

  def add_comment
    candidate_note = CandidateNote.new(comment: params.require(:comment), employee: current_employee)
    candidate = Candidate.find(params[:candidate_id])
    candidate.candidate_notes << candidate_note
    redirect_to candidate
  end
end
