class InvitePresenter < SimpleDelegator
  include Rails.application.routes.url_helpers

  delegate :content_tag, :link_to, to: :h

  def initialize(invite, user)
    @invite = invite
    @user = user
    super(invite)
  end

  def self.decorate_collection(invites, user)
    invites.map { |invite| new(invite, user) }
  end

  def invite_links
    return invite_accepted if accepted?
    return invite_rejected if rejected?
    return invite_pending if @user.is_a? Candidate

    invite_pending_company
  end

  private

  def invite_accepted
    content_tag :p, "Esse convite foi aceito em
                        #{ I18n.l(accepted_or_rejected_at,
                                  format: :long) }"
  end

  def invite_rejected
    content_tag :p, 'Esse convite foi rejeitado em '\
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
end
