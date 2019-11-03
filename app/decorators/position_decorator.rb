class PositionDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def salary
    number_to_currency(salary_from) +
      t('activerecord.messages.position.salary_separator') +
      number_to_currency(salary_to)
  end
end
