class CompanyProfileDecorator < Draper::Decorator
  include Draper::LazyHelpers

  def initialize(company)
    @company = company
  end

  def company_profile_link
    return link_to_edit_profile if company_profile_complete?

    link_to_complete_profile
  end

  def card_render
    render(partial: 'shared/dashboard_card_button',
           locals: invites_card_locals) +
      render(partial: 'shared/dashboard_card_button',
             locals: selection_processes_card_locals) +
      render(partial: 'shared/dashboard_card_button',
             locals: interviews_card_locals)
  end

  def link_to_edit_profile
    link_to 'Editar perfil da empresa',
            edit_company_profile_path(@company.company_profile),
            class: 'btn btn-outline-dark'
  end

  def link_to_complete_profile
    content_tag :div, class: 'row justify-content-center' do
      link_to 'Completar perfil da empresa', new_company_profile_path,
              class: 'btn btn-outline-dark'
    end
  end

  private

  def invites_card_locals
    { icon: 'fa-edit',
      title: I18n.t('activerecord.models.invite').pluralize,
      count: @company.invites.pending.count,
      id: 'invites-card',
      path: 'invites' }
  end

  def selection_processes_card_locals
    { icon: 'fa-edit',
      title: I18n.t('selection_process.plural'),
      count: CompanySelectionProcessesQuery.new(@company).count,
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
