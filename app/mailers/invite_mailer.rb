class InviteMailer < ApplicationMailer
  def notify_candidate(invite_id)
    @invite = Invite.find(invite_id)
    @position = @invite.position
    @company = @invite.position.company
    mail(to: @invite.candidate.email, subject: "#{@invite.candidate.name}, você foi convidado para uma posição na #{@invite.position.company.name}")
  end
end
