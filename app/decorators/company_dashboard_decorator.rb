class CompanyDashboardDecorator < Draper::Decorator
  include Draper::LazyHelpers

  def initialize(company)
    @company = company
  end

  def card_render
    if published?
      render(partial: 'shared/dashboard_card_button',
             locals: card_locals('fa-envelope-open-text', Invite.name)) # +
    else
      ''
    end
  end

  private

  attr_accessor :company

  def card_locals(icon, class_name)
    byebug
    { icon: icon,
      title: title(class_name),
      count: count(class_name),
      id: "#{class_name.pluralize.downcase}-card",
      path: path(class_name) }
  end

  def published?
    company.published?
  end

  def count(class_name)
    byebug
    company.position.send(class_name.pluralize.downcase).count
  end

  def path(class_name)
    class_name.pluralize.downcase.to_s
  end

  def title(class_name)
    I18n.t("activerecord.models.#{class_name.downcase}").pluralize
  end

end
