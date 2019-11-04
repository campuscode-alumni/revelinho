class CandidatesPresenter < SimpleDelegator
  attr_reader :candidates

  delegate :content_tag, :link_to, to: :h

  def initialize(candidates)
    @candidates = candidates
  end

  def no_candidates_message
    if @candidates.published.count < 1
      content_tag(:div, I18n.t('candidates.messages.no_candidates'),
                  class: 'alert alert-primary', role: 'alert')
    else
      ''
    end
  end

  private

  def h
    ApplicationController.helpers
  end
end
