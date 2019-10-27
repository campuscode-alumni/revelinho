class InterviewDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  def format_datetime
    date = interview.datetime.strftime('%d/%m/%Y')
    time = interview.datetime.strftime('%R')
    I18n.t('activerecord.attributes.interview.datetime', date: date, time: time)
  end

  def decision_buttons
    return '' unless interview.pending?

    reject_button + accept_button
  end

  def interview_status_badge
    if interview.pending?
      content_tag(:span, I18n.t('status_badge.pending'),
                  class: 'badge badge-warning')
    elsif interview.scheduled?
      content_tag(:span, I18n.t('status_badge.scheduled'),
                  class: 'badge badge-primary')
    elsif interview.canceled?
      content_tag(:span, I18n.t('status_badge.rejected'),
                  class: 'badge badge-danger')
    end
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
