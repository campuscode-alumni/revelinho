class InterviewDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  def formatting_datetime
    I18n.l(interview.date, format: :long) + ', das ' + interview.time_from +
      ' às ' + interview.time_to
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
    return scheduled_badge if interview.scheduled?
    return canceled_badge if interview.canceled?

    pending_badge
  end

  private

  def pending_badge
    content_tag(:span, I18n.t('interview.status_badge.pending'),
                class: 'badge badge-warning mb-2')
  end

  def scheduled_badge
    content_tag(:span, I18n.t('interview.status_badge.scheduled'),
                class: 'badge badge-primary mb-2')
  end

  def canceled_badge
    content_tag(:span, I18n.t('interview.status_badge.rejected'),
                class: 'badge badge-danger mb-2')
  end

  def accept_button
    link_to 'Aceitar', accept_interview_candidate_path(interview),
            class: 'btn btn-outline-success', method: :post
  end

  def reject_button
    link_to 'Recusar', reject_interview_candidate_path(interview),
            class: 'btn btn-outline-danger', method: :post
  end
end
