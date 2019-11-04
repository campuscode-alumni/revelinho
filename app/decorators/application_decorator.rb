class ApplicationDecorator < Draper::Decorator
  include ActionView::Helpers::OutputSafetyHelper
  include Draper::LazyHelpers
  attr_accessor :application

  delegate :flash, to: :application

  def initialize(application)
    @application = application
  end

  def flash_alerts
    safe_join(
      flash.map do |key, value|
        content_tag(:div, value, class: "alert alert-#{key}", role: 'alert')
      end
    )
  end
end
