class InterviewMailer < ApplicationMailer
  def interview_accepted(id)
    @interview = Interview.find(id)
    @selection_process = @interview.selection_process
    @invite = @selection_process.invite
    mail(to: @invite.employee.email, subject: 'O candidato '\
      "#{@invite.candidate.name} aceitou o convite para a entrevista.")
  end
end
