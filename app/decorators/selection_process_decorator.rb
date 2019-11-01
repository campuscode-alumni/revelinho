class SelectionProcessDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def contract_resume
    p_print_hiring_scheme + p_print_office_hours + p_print_salary
  end

  def messages_show
    messages.order(id: :desc).decorate
  end

  def offers_menu
    return '' unless employee_signed_in?

    btn_offer + msg_offer
  end

  def main_contact
    return employee_main_contact unless candidate_signed_in?

    candidate_main_contact
  end

  private

  def candidate_main_contact
    content_tag(:p, content_tag(:small, employee.name), class: 'mb-0') +
      content_tag(:p, content_tag(:small, "Telefone: #{company_profile.phone}"),
                  class: 'mb-0') +
      content_tag(:p, content_tag(:small, "Email: #{employee.email}"),
                  class: 'mb-0')
  end

  def employee_main_contact
    content_tag(:p, content_tag(:small, candidate.name), class: 'mb-0') +
      content_tag(:p, content_tag(:small, "Telefone: #{candidate.phone}"),
                  class: 'mb-0') +
      content_tag(:p, content_tag(:small, "Email: #{candidate.email}"),
                  class: 'mb-0')
  end

  def btn_offer
    link_to 'Quero contrata-lo!', new_candidate_offer_path(candidate.id, id),
            class: 'btn btn-info btn-lg mb-3'
  end

  def msg_offer
    return unless offers.pending.any?

    content_tag(:div, 'Proposta realizada! Aguardando retorno do candidato.',
                class: 'alert alert-info')
  end

  def p_print_hiring_scheme
    content_tag(:p, class: 'mb-0') do
      'Regime de contratação: ' +
        I18n.t('activerecord.attributes.position.hiring_scheme.' +
        position.hiring_scheme)
    end
  end

  def p_print_office_hours
    content_tag(:p, class: 'mb-0') do
      'Horário de expediente: ' +
        I18n.t('activerecord.attributes.position.office_hours.' +
        position.office_hours)
    end
  end

  def p_print_salary
    content_tag(:p, class: 'mb-0') do
      "Salário: #{number_to_currency(position.salary_from)}"\
        " à #{number_to_currency(position.salary_to)}"
    end
  end
end
