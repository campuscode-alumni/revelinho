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
    return menu_employee if employee_signed_in?
    return menu_candidate if offers.pending.any?
    return menu_accepted if offers.accepted.any?
  end

  def logo_process
    link_to image_tag(company_profile.logo,
                      class: 'avatar-process float-left mr-2'),
            company_path(company)
  end

  def schedule_interview_link
    return '' unless employee_signed_in?

    link_to 'Agendar entrevista',
            new_selection_process_interview_path(selection_process),
            class: 'btn btn-primary'
  end

  private

  def accept_btn
    link_to('Aceitar proposta',
            accept_candidate_offer_path(candidate.id, id,
                                        offers.pending.first.id),
            class: 'btn btn-success btn-lg mt-2 mr-3', method: 'post')
  end

  def reject_btn
    link_to('Rejeitar proposta',
            reject_candidate_offer_path(candidate.id, id,
                                        offers.pending.first.id),
            class: 'btn btn-danger btn-lg mt-2', method: 'post')
  end

  def menu_employee
    btn_offer + msg_offer
  end

  def menu_accepted
    content_tag :div, class: 'card card-body bg-success text-white' do
      content_tag(:h4, 'Oferta aceita!') +
        content_tag(:p, 'Agora é só aguardar o contato de sua nova casa!') +
        content_tag(:p, 'Nós da Revelinho desejamos muito sucesso em '\
                        'sua carreira. :D')
    end
  end

  def menu_candidate
    content_tag :div, class: 'card card-body text-center' do
      content_tag(:h4, 'PROPOSTA RECEBIDA! \o/') +
        content_tag(:p, 'Parabéns! Você recebeu uma proposta. Agora avalie '\
                        'e veja se atende as suas expectativas') +
        content_tag(:p, offer_description(offers.pending.first)) +
        content_tag(:div, (accept_btn + reject_btn), class: 'text-center')
    end
  end

  def offer_description(offer)
    content_tag(:p, "Salário: #{number_to_currency(offer.salary)}",
                class: 'mb-0') +
      content_tag(:p, "Regime de contratação: #{I18n.t('activerecord.attribute'\
                      "s.offer.hiring_scheme.#{offer.hiring_scheme}")}",
                  class: 'mb-0') +
      content_tag(:p, "Data de início: #{offer.decorate.format_date}",
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
