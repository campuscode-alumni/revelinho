class ApplicationPresenter < SimpleDelegator
  include ActionView::Helpers::OutputSafetyHelper
  include Rails.application.routes.url_helpers

  attr_reader :application

  delegate :content_tag, :link_to, to: :h
  delegate :signed_in?, to: :application

  def initialize(application)
    @application = application
    super(application)
  end

  def flash_alerts
    safe_join(
      flash.map do |key, value|
        content_tag(:div, value, class: "alert alert-#{key}", role: 'alert')
      end
    )
  end

  def nav_links
    safe_join([nav_candidates, nav_sign_in, nav_sign_out])
  end

  private

  def nav_candidates
    return nav_builder(t('navbar.candidates'), candidates_path) if signed_in?

    ''
  end

  def nav_sign_out
    return nav_builder(t('navbar.logout'), logout_path, :delete) if signed_in?

    ''
  end

  def nav_sign_in
    return '' if signed_in?

    nav_builder(t('navbar.sign_in.employee'), new_employee_session_path) +
      nav_builder(t('navbar.sign_in.candidate'), new_candidate_session_path)
  end

  def nav_builder(text, path, method = :get)
    content_tag(:li, class: 'nav-item') do
      link_to(text, path, method: method,
                          class: 'nav-link p-2 ' \
                            'text-uppercase small')
    end
  end

  def logout_path
    return destroy_candidate_session_path if candidate_signed_in?
    return destroy_employee_session_path if employee_signed_in?

    root_path
  end

  def h
    ApplicationController.helpers
  end
end
