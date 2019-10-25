class InterviewDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  def format_datetime
    'Dia ' + interview.datetime.strftime('%d/%m/%Y') +
      ' às ' + interview.datetime.strftime('%R')
  end

  def decision_buttons
    return '' unless interview.pending?

    reject_button + accept_button
  end

  def interview_status_badge
    if interview.pending?
      content_tag(:span, 'Aguardando resposta', class: 'badge badge-warning')
    elsif interview.scheduled?
      content_tag(:span, 'Entrevista agendada', class: 'badge badge-primary')
    elsif interview.canceled?
      content_tag(:span, 'Entrevista cancelada', class: 'badge badge-danger')
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
