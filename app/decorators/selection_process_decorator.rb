class SelectionProcessDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  def contract_resume
    p_print_hiring_scheme + p_print_office_hours + p_print_salary
  end

  def go_back_button (user)
    return invites_candidates_path if user.is_a? Candidate

    candidates_path
  end

  private

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
