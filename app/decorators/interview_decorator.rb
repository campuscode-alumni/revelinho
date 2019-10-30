class InterviewDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def time_from_localized
    I18n.localize(Time.zone.parse(time_from, Time.zone.now), format: :short)
  end

  def time_to_localized
    I18n.localize(Time.zone.parse(time_to, Time.zone.now), format: :short)
  end
end
