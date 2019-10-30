class CompanyProfileDecorator < Draper::Decorator
  include Draper::LazyHelpers

  def initialize(company)
    @company = company
  end

  def company_profile_link
    if company_profile_complete?
      link_to 'Editar perfil da empresa',
              edit_company_profile_path(@company.company_profile),
              class: 'btn btn-outline-dark'
    else
      content_tag :div, class: 'row justify-content-center' do
        link_to 'Completar perfil da empresa', new_company_profile_path,
                class: 'btn btn-outline-dark'
      end
    end
  end

  def card_render
    render(partial: 'shared/dashboard_card_button',
           locals: invites_card_locals) +
      render(partial: 'shared/dashboard_card_button',
             locals: selection_processes_card_locals) +
      render(partial: 'shared/dashboard_card_button',
             locals: interviews_card_locals)
  end

  private

  def invites_by_company(company)
    Invite.includes(:position).where(positions: { company: company })
  end

  def invites_card_locals
    { icon: 'fa-edit',
      title: I18n.t('activerecord.models.invite').pluralize,
      count: invites_by_company(@company).pending.count,
      id: 'invites-card',
      path: 'invites' }
  end

  def selection_processes_card_locals
    { icon: 'fa-edit',
      title: I18n.t('activerecord.models.selection_process.plural'),
      count: invites_by_company(@company).accepted.count,
      id: 'selection-processes-card',
      path: 'selection_processes' }
  end

  def interviews_card_locals
    { icon: 'fa-edit',
      title: I18n.t('activerecord.models.interview.plural'),
      count: 1,
      id: 'interviews-card',
      path: 'interviews' }
  end

  def company_profile_complete?
    @company.company_profile.present?
  end
end
