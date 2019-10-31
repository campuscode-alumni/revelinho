class CompanyInvitesPresenter < SimpleDelegator
  include Rails.application.routes.url_helpers
  attr_reader :invites, :company

  delegate :content_tag, :link_to, to: :h

  def initialize(company)
    @company = company
    @invites = company.invites.all
    super(company)
  end

  def no_invites_warning
    return '' if @invites.any?

    content_tag(:div, class: 'alert alert-secondary', role: 'alert') do
      content_tag(:p, 'Ainda não há convites', class: 'alert-heading') +
        content_tag(:hr) +
        content_tag(:p, class: 'mb-0') do
          link_to('Clique aqui', candidates_path) + ' ' \
            'para começar a convidar candidatos'
        end
    end
  end

  private

  def h
    ApplicationController.helpers
  end
end
