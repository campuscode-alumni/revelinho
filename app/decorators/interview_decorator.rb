class InterviewDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  def formatting_datetime
    I18n.l(interview.datetime, format: :long)
  end

  def interview_address
    I18n.t('activerecord.attributes.interview.address',
           address: interview.address)
  end

  def interview_format
    I18n.t('activerecord.attributes.interview.format.' + interview.format)
  end

  def decision_buttons
    return '' unless interview.pending?

    reject_button + accept_button
  end

  def interview_status_badge
    badge_info = InterviewBadges.picker interview.status
    content_tag(:span, badge_info[:content], class: badge_info[:class])
  end

  def status_footer
    # TODO
    # select field + button
    # change interview content format
  end

  private

  def accept_button
    link_to 'Aceitar', accept_interview_candidate_path(interview),
            class: 'btn btn-outline-success', method: :post
  end

  def reject_button
    link_to 'Recusar', reject_interview_candidate_path(interview),
            class: 'btn btn-outline-danger', method: :post
  end
end
