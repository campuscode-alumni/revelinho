class CompanyInterviewsPresenter < SimpleDelegator
  include Rails.application.routes.url_helpers
  attr_reader :interviews, :company

  delegate :content_tag, :link_to, to: :h

  def initialize(company)
    @company = company
    @interviews = CompanyInterviews.new(company).interviews
    super(company)
  end

  def no_interviews_warning
    return '' unless @interviews.any?

    content_tag(:div, class: 'alert alert-secondary', role: 'alert') do
      content_tag(:p, 'Ainda não há entrevistas', class: 'alert-heading') +
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
