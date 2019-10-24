class InterviewDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def time_from_localized
    I18n.localize(Time.parse(time_from, Time.now), format: :short)
  end

  def time_to_localized
    I18n.localize(Time.parse(time_to, Time.now), format: :short)
  end
end
