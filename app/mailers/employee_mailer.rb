class EmployeeMailer < ApplicationMailer
  def interview_accepted(id)
    @interview = Interview.find(id)
    @selection_process = @interview.selection_process
    @invite = @selection_process.invite
    mail(to: @invite.employee.email, subject: 'O candidato '\
      "#{@invite.candidate.name} aceitou o convite para a entrevista.",
         body: "#{@invite.candidate.name} aceitou o convite para a entrevista"\
         "do dia #{@interview.datetime}, em #{@interview.address}, "\
         "#{@interview.format}. A entrevista é referente a vaga de: "\
         "#{invite.position.title}. Para acessar clique no link abaixo:"\
         "#{selection_process_candidates_path(@selection_process)}"
    )
  end
end
