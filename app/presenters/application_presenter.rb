class ApplicationPresenter < SimpleDelegator
  include ActionView::Helpers::OutputSafetyHelper
  include Rails.application.routes.url_helpers

  attr_reader :user

  delegate :content_tag, :link_to, to: :h

  def initialize(user = nil)
    @user = user
  end

  def nav_links
    safe_join([nav_candidates, nav_sign_in, nav_user_options])
  end

  private

  def nav_candidates
    if logged_as_employee?
      nav_builder(I18n.t('navbar.candidates'), candidates_path)
    else
      ''
    end
  end

  def nav_user_options
    return '' if not_signed_in?

    content_tag(:li, class: 'nav-items dropdown') do
      content_tag(:a, nav_user_title,
                  class: 'nav-link dropdown-toggle p-2 text-uppercase',
                  href: '#', id: 'navbarDropdown', role: 'button',
                  data: { toggle: 'dropdown' },
                  aria: { haspopup: 'true', expanded: 'false' }) +
        nav_user_options_items
    end
  end

  def nav_user_title
    return I18n.t('navbar.title.company') if logged_as_employee?
    return I18n.t('navbar.title.candidate') if logged_as_candidate?
  end

  def nav_user_options_items
    items = []
    items.concat(nav_user_options_employee) if logged_as_employee?
    items.concat(nav_user_options_candidate) if logged_as_candidate?
    items.concat([{ text: I18n.t('navbar.logout'), path: logout_path,
                    method: :delete }])

    content_tag(:div, class: 'dropdown-menu dropdown-menu-right',
                      aria: { labelledby: 'navbarDropdown' }) do
      safe_join(items.map { |item| nav_dropdown_item_builder(item) })
    end
  end

  def nav_user_options_employee
    [{ text: I18n.t('navbar.see_company'),
       path: company_path(user.company) },
     { text: I18n.t('navbar.edit_company'),
       path: edit_company_profile_path(user.company) },
     { text: I18n.t('navbar.create_position'),
       path: new_position_path }]
  end

  def nav_user_options_candidate
    [{ text: I18n.t('navbar.candidate_profile'),
       path: my_profile_candidates_path },
     { text: I18n.t('navbar.edit_candidate'),
       path: edit_candidate_profile_path(user) }]
  end

  def nav_sign_in
    return '' if signed_in?

    content_tag(:li, class: 'nav-items dropdown') do
      content_tag(:a, 'Login/Cadastro',
                  class: 'nav-link dropdown-toggle p-2 text-uppercase',
                  href: '#', id: 'navbarLoginDropdown', role: 'button',
                  data: { toggle: 'dropdown' },
                  aria: { haspopup: 'true', expanded: 'false' }) +
        nav_sign_in_items
    end
  end

  def nav_sign_in_items
    content_tag(:div, class: 'dropdown-menu dropdown-menu-right',
                      aria: { labelledby: 'navbarDropdown' }) do
      nav_dropdown_item_builder(text: I18n.t('navbar.sign_in.employee'),
                                path: new_employee_session_path) +
        nav_dropdown_item_builder(text: I18n.t('navbar.sign_in.candidate'),
                                  path: new_candidate_session_path)
    end
  end

  def nav_builder(text, path, method = :get)
    content_tag(:li, class: 'nav-item') do
      link_to(text, path, method: method,
                          class: 'nav-link p-2 ' \
                            'text-uppercase')
    end
  end

  def nav_dropdown_item_builder(options)
    link_to(options[:text], options[:path], class: 'dropdown-item',
                                            method: options[:method] || :get)
  end

  def logout_path
    return destroy_candidate_session_path if logged_as_candidate?
    return destroy_employee_session_path if logged_as_employee?
  end

  def signed_in?
    user.present?
  end

  def not_signed_in?
    user.nil?
  end

  def logged_as_employee?
    user.is_a?(Employee)
  end

  def logged_as_candidate?
    user.is_a?(Candidate)
  end

  def h
    ApplicationController.helpers
  end
end
