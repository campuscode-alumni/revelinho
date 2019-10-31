class InterviewDecorator < Draper::Decorator
  include Draper::LazyHelpers
  attr_reader :interview, :user

  delegate_all

  def initialize(interview, user)
    @interview = interview
    @user = user
    super(interview)
  end

  def self.decorate_collection (interview, user)
    interview.map { |interview| new(interview, user) }
  end

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

  def interview_status_badge
    badge_info = InterviewBadges.picker interview.status
    content_tag(:span, badge_info[:content], class: badge_info[:class])
  end

  def footer
    return decision_buttons if user.is_a? Candidate
    
    employee_footer
  end

  private

  def decision_buttons
    return '' unless interview.pending?
    
    render(partial: 'interviews/candidate_buttons',
    locals: { interview: interview})
  end

  def employee_footer
    return feedback_button if interview.done?

    status_picker
  end

  def feedback_button
    link_to 'Ver feedbacks', interview_feedback_candidates_path,
            class: 'btn btn-outline-primary'
  end

  def status_picker
    render(partial: 'interviews/status_picker',
    locals: { interview: interview})
  end
end
