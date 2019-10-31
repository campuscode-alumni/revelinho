class CompanyProfilePresenter < SimpleDelegator
  include Rails.application.routes.url_helpers

  delegate :content_tag, :link_to, to: :h

  def initialize(company)
    @company = company
  end

  def company_profile_link
    if company_profile_complete?
      h.link_to 'Editar perfil da empresa',
                edit_company_profile_path(@company.company_profile),
                class: 'btn btn-outline-dark'
    else
      h.content_tag :div, class: 'row justify-content-center' do
        h.link_to 'Completar perfil da empresa', new_company_profile_path,
                  class: 'btn btn-outline-dark'
      end
    end
  end

  private

  def company_profile_complete?
    @company.company_profile.present?
  end

  def h
    ApplicationController.helpers
  end
end
