class OfferDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def format_date
    start_date.strftime('%d/%m/%Y')
  end
end
