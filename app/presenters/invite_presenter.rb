class InvitePresenter < SimpleDelegator
  include Rails.application.routes.url_helpers

  delegate :content_tag, :link_to, to: :h

  def initialize; end

  def invite_accepted(invite)
    if invite.accepted?
      return content_tag :p, "Esse convite foi aceito em
                         #{ I18n.l(invite.accepted_or_rejected_at,
                                   format: :long) }"
    end
    ''
  end

  def invite_rejected(invite)
    if invite.rejected?
      return content_tag :p, 'Esse convite foi rejeitado em '\
                        "#{ I18n.l(invite.accepted_or_rejected_at,
                                   format: :long) }"
    end
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

  def invite_pending_company(invite)
    return content_tag :p, 'Esse convite está pendente ' if invite.pending?
  end

  private

  def h
    ApplicationController.helpers
  end
end
