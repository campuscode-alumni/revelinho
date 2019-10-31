class InviteDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def invite_links
    return link_process unless pending?

    links_invite_choice
  end

  def logo
    return company_profile.logo if company_profile.logo.attached?

    image_url('placeholder.png')
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
