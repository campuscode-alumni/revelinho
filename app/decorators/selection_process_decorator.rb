class SelectionProcessDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def contract_resume
    content_tag(:p, class: 'mb-0') do
      'Regime de contratação: ' +
        I18n.t('activerecord.attributes.position.position_type.' +
        position.position_type)
    end +
      content_tag(:p, class: 'mb-0') do
        "Salário: #{number_to_currency(position.salary_from)}"\
          " à #{number_to_currency(position.salary_to)}"
      end
  end
end
