class UserPresenter < SimpleDelegator
  include Rails.application.routes.url_helpers

  delegate :content_tag, :link_to, to: :h

  def initialize(user)
    super(user)
  end

  def logout_link
    return '' unless present?

    content_tag :li, class: 'nav-item' do
      link_to 'Logout', "/#{self.class.downcase.pluralize}/sign_out", 
      method: :delete, class: 'nav-link p-3'
    end
  end

  private

  def employee?
    is_a? Employee
  end

  def employee_logout_link
    content_tag :li, class: 'nav-item' do
      link_to 'Logout', destroy_employee_session_path, 
              method: :delete, class: 'nav-link p-3'
    end
  end

  def h
    ApplicationController.helpers
  end
end