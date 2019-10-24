class InterviewDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  def format_datetime
    'Dia ' + interview.datetime.strftime('%d/%m/%Y') +
      ' às ' + interview.datetime.strftime('%R')
  end
end
