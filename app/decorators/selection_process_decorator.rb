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
    return main_content(employee_data) if candidate_signed_in?

    main_content(candidate_data)
  end

  private

  def employee_data
    {
      image: { avatar: company_profile.logo, path: candidate_path(candidate) },
      title: company.name,
      description: { name: employee.name, email: employee.email,
                     phone: company_profile.phone }
    }
  end

  def candidate_data
    {
      image: { avatar: candidate.avatar, path: company_path(company) },
      title: '',
      description: { name: candidate.name, phone: candidate.phone,
                     email: candidate.email }
    }
  end

  def main_content(data)
    link_to(image_tag(data[:image][:avatar],
                      class: 'avatar-100 float-left mr-2'),
            data[:image][:path]) +
      content_tag(:div, class: 'float-left pl-2') do
        content_tag(:h5, data[:title], class: 'main-title') +
          content_tag(:h6, 'Seu contato principal é:', class: 'lead-4') +
          description(data[:description])
      end
  end

  def description(data)
    content_tag(:p, content_tag(:small, data[:name])) +
      content_tag(:p, content_tag(:small, "Telefone: #{data[:phone]}")) +
      content_tag(:p, content_tag(:small, "Email: #{data[:email]}"))
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
