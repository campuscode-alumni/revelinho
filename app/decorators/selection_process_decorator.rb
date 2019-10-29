class SelectionProcessDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def contract_resume
    p_print_hiring_scheme + p_print_office_hours + p_print_salary
  end

  def messages_show
    messages.order(id: :desc)
  end

  def offers_menu
    return menu_employee if employee_signed_in?
    return menu_candidate if offers.pending.any?
  end

  private

  def menu_employee
    btn_offer + msg_offer
  end

  def menu_candidate
    content_tag :div, class: 'alert alert-info' do
      content_tag(:h4, 'PROPOSTA RECEBIDA! \o/') +
        content_tag(:small, 'Parabéns! Você recebeu uma proposta. Agora avalie'\
                            ' e veja se atende as suas expectativas') +
        link_to('Ver proposta', candidate_offer_path(candidate.id, id,
                                                     offers.pending.first.id),
                class: 'btn btn-info btn-lg btn-block mt-2')
    end
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
