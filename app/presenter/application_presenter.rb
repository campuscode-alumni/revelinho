class ApplicationPresenter < SimpleDelegator
  include ActionView::Helpers::OutputSafetyHelper

  attr_reader :application

  delegate :content_tag, :link_to, to: :h

  def initialize(application)
    @application = application
    super(application)
  end

  def flash_alerts
    safe_join(
      flash.map do |key, value|
        content_tag :div, value, class: "alert alert-#{key}", role: 'alert'
      end
    )
  end

  private

  def h
    ApplicationController.helpers
  end
end
