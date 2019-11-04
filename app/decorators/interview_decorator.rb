class InterviewDecorator < Draper::Decorator
  include Draper::LazyHelpers
  attr_reader :interview, :user

  delegate_all

  def initialize(interview, user)
    @interview = interview
    @user = user
    super(interview)
  end

  def self.decorate_collection(interview, user)
    interview.map { |i| new(i, user) }
  end

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

  def interview_status_badge
    badge_info = InterviewBadges.picker interview.status
    content_tag(:span, badge_info[:content], class: badge_info[:class])
  end

  def footer
    return decision_buttons if user.is_a? Candidate

    employee_footer
  end

  def status_buttons
    safe_join(Interview.statuses.map do |stats|
      link_to(
        I18n.t("activerecord.attributes.interview.status.#{stats[0]}"),
        set_interview_status_candidate_path(interview, status: stats[0].to_sym),
        class: 'dropdown-item', method: :post
      )
    end)
  end

  private

  def decision_buttons
    return '' unless interview.pending?

    render(partial: 'interviews/candidate_buttons',
           locals: { interview: interview })
  end

  def employee_footer
    return status_picker + feedback_button if interview.done?

    status_picker
  end

  def feedback_button
    link_to 'Feedbacks', interview_feedback_candidates_path(interview),
            class: 'btn btn-info'
  end

  def status_picker
    render(partial: 'interviews/status_picker',
           locals: { interview: interview })
  end
end
