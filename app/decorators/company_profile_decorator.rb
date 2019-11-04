class CompanyProfileDecorator < Draper::Decorator
  include Draper::LazyHelpers

  def initialize(company)
    @company = company
  end

  def company_profile_link
    return link_to_complete_profile unless company_profile_complete?

    ''
  end

  def card_render
    render(partial: 'shared/dashboard_card_button',
           locals: invites_card_locals) +
      render(partial: 'shared/dashboard_card_button',
             locals: selection_processes_card_locals) +
      render(partial: 'shared/dashboard_card_button',
             locals: interviews_card_locals)
  end

  def link_to_complete_profile
    content_tag :div, class: 'row justify-content-center' do
      link_to 'Completar perfil da empresa', new_company_profile_path,
              class: 'btn btn-outline-dark'
    end
  end

  private

  def count
    count_invite = 0
    @company.positions.each do |position|
      count_invite += position.invites.count
    end
    count_invite
  end

  def invites_card_locals
    { icon: 'fa-edit',
      title: I18n.t('activerecord.models.invite').pluralize,
      count: count,
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
