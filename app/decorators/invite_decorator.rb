class InviteDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def invite_links
    return links_invite_choice if invite.pending?
    return link_process if invite.accepted?
  end

  def date
    l(invite.created_at.to_date, format: :long)
  end

  private

  def links_invite_choice
    link_to('Aceitar', accept_invites_candidate_path(invite),
            method: :post, class: 'btn btn-success flex-grow-1 m-3') +
      link_to('Rejeitar', reject_invites_candidate_path(invite),
              method: :post, class: 'btn btn-danger flex-grow-1 m-3')
  end

  def link_process
    link_to('Ver convite',
            selection_process_candidates_path(invite.selection_process),
            class: 'btn btn-primary flex-grow-1 m-3')
  end
end
