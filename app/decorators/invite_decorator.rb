class InviteDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def link_process
    link_invite if invite.accepted?
  end

  def logo
    return company_profile.logo if company_profile.logo.attached?

    image_url('placeholder.png')
  end

  private

  def link_invite
    link_to('Ver convite',
            selection_process_candidates_path(invite.selection_process),
            class: 'btn btn-primary flex-grow-1 m-3')
  end
end
