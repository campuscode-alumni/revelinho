class InvitePresenter < SimpleDelegator
  include Rails.application.routes.url_helpers

  delegate :content_tag, :link_to, to: :h

  def initialize(invite)
    @invite = invite
    super(invite)
  end

  def self.decorate_collection(invites)
    invites.map { |invite| new(invite) }
  end

  def invite_links
    if accepted?
      invite_accepted
    elsif rejected?
      invite_rejected
    else
      invite_pending
    end
  end


  def invite_links_company
    if accepted?
      invite_accepted
    elsif rejected?
      invite_rejected
    else
      invite_pending_company
    end
  end

  def invite_accepted
    content_tag :p, "Esse convite foi aceito em
                        #{ I18n.l(accepted_or_rejected_at,
                                  format: :long) }"
  end

  def invite_rejected
    message = content_tag :p, 'Esse convite foi rejeitado em '\
      "#{I18n.l(accepted_or_rejected_at, format: :long)}"
  end

  def invite_pending
    reject = link_to 'Rejeitar convite', reject_invites_candidate_path(self),
                     method: :post, class: 'btn btn-danger flex-grow-1 m-3'
    accept = link_to 'Aceitar convite', accept_invites_candidate_path(self),
                     method: :post, class: 'btn btn-success flex-grow-1 m-3'
    reject + accept
  end

  def invite_pending_company
    content_tag :p, 'Esse convite está pendente '
  end

  def h
    ApplicationController.helpers
  end

  private

end
