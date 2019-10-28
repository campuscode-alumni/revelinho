class CandidateMailer < ApplicationMailer
  def notify_invite_to_candidate(invite_id)
    @invite = Invite.find(invite_id)
    @position = @invite.position
    @company = @invite.company

    mail(to: @invite.candidate.email,
         subject: 'Você recebeu um convite!')
  end
end
