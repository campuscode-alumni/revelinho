class InterviewDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  def formatting_datetime
    date = interview.datetime.strftime('%d/%m/%Y')
    time = interview.datetime.strftime('%R')
    I18n.t('activerecord.attributes.interview.datetime', date: date, time: time)
  end

  def interview_address
    I18n.t('activerecord.attributes.interview.address',
           address: interview.address)
  end

  def interview_format
    I18n.t('format.' + interview.format)
  end

  def decision_buttons
    return '' unless interview.pending?

    reject_button + accept_button
  end

  def interview_status_badge
    return pending_badge if interview.pending?
    return scheduled_badge if interview.scheduled?
    return canceled_badge if interview.canceled?
  end

  private

  def pending_badge
    content_tag(:span, I18n.t('status_badge.pending'),
                class: 'badge badge-warning')
  end

  def scheduled_badge
    content_tag(:span, I18n.t('status_badge.scheduled'),
                class: 'badge badge-primary')
  end

  def canceled_badge
    content_tag(:span, I18n.t('status_badge.rejected'),
                class: 'badge badge-danger')
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
