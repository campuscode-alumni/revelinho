class CandidateNoteDecorator < Draper::Decorator
  delegate_all

  def sent_by
    "@#{candidate_note.employee.email.split('@')[0]}"
  end
end
