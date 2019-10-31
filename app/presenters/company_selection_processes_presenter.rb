class CompanySelectionProcessesPresenter < SimpleDelegator
  include Rails.application.routes.url_helpers
  attr_reader :selection_processes, :company

  delegate :content_tag, :link_to, to: :h

  def initialize(company)
    @company = company
    @selection_processes = CompanySelectionProcessesQuery.new(company).all
    super(company)
  end

  def no_selection_processes_warning
    return '' if @selection_processes.any?

    content_tag(:div, class: 'alert alert-secondary', role: 'alert') do
      content_tag(:p, t('selection_process.messages.empty'),
                  class: 'alert-heading') +
        content_tag(:hr) +
        warning_see_candidates
    end
  end

  private

  def warning_see_candidates
    content_tag(:p, class: 'mb-0') do
      link_to(t('selection_process.messages.click_here'), candidates_path) +
        ' ' + t('selection_process.messages.to_schedule_interviews')
    end
  end

  def h
    ApplicationController.helpers
  end
end
