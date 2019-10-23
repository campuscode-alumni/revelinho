class InvitePresenter < SimpleDelegator
  include Rails.application.routes.url_helpers

  delegate :content_tag, :link_to, to: :h

  def initialize; end

  def invite_accepted(invite)
    return content_tag :p, 'Esse convite foi aceito' if invite.accepted?
    ''
  end

  def invite_rejected(invite)
    return content_tag :p, 'Esse convite foi rejeitado' if invite.rejected?
    ''
  end

  def invite_pending(invite)
    reject = link_to 'Rejeitar convite', reject_invites_candidate_path(invite),
                     method: :post, class: 'btn btn-danger flex-grow-1 m-3'
    accept = link_to 'Aceitar convite', accept_invites_candidate_path(invite),
                     method: :post, class: 'btn btn-success flex-grow-1 m-3'
    return reject + accept if invite.pending?
    ''
  end

  private

  def h
    ApplicationController.helpers
  end
end
