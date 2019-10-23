class InviteDecorator < Draper::Decorator
  include Draper::LazyHelpers
  def initialize(invites)
  end

  def invite_links(invite)
    return link_process(invite) unless invite.pending?

    links_invite_choice(invite)
  end

  private

  def links_invite_choice(invite)
    link_to('Aceitar', accept_invites_candidate_path(invite),
            method: :post, class: 'btn btn-success flex-grow-1 m-3') +
      link_to('Rejeitar', reject_invites_candidate_path(invite),
              method: :post, class: 'btn btn-danger flex-grow-1 m-3')
  end

  def link_process(invite)
    link_to('Ver convite',
            selection_process_candidates_path(invite.selection_process),
            class: 'btn btn-primary flex-grow-1 m-3')
  end
end
