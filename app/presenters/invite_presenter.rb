class InvitePresenter < SimpleDelegator
  include Rails.application.routes.url_helpers

  delegate :content_tag, :link_to, to: :h

  def self.decorate_collection(invites)
    invites.map { |invite| new(invite) }
  end

  def invite_accepted
    if accepted?
      return content_tag :p, "Esse convite foi aceito em
                         #{ I18n.l(accepted_or_rejected_at,
                                   format: :long) }"
    end
    ''
  end

  def invite_rejected
    if rejected?
      return content_tag :p, 'Esse convite foi rejeitado em '\
                        "#{ I18n.l(accepted_or_rejected_at,
                                   format: :long) }"
    end
    ''
  end

  def invite_pending
    reject = link_to 'Rejeitar convite', reject_invites_candidate_path(self),
                     method: :post, class: 'btn btn-danger flex-grow-1 m-3'
    accept = link_to 'Aceitar convite', accept_invites_candidate_path(self),
                     method: :post, class: 'btn btn-success flex-grow-1 m-3'
    return reject + accept if pending?

    ''
  end

  def invite_pending_company
    return content_tag :p, 'Esse convite está pendente ' if pending?
  end

  private

  def h
    ApplicationController.helpers
  end
end
