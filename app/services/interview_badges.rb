class InterviewBadges
  def self.picker status
    send("#{status}_badge")
  end

  private

  def self.pending_badge
    { content: I18n.t('interview.status_badge.pending'),
      class: 'badge badge-warning mb-2'}
  end

  def self.scheduled_badge
    { content: I18n.t('interview.status_badge.scheduled'),
      class: 'badge badge-primary mb-2'}
  end

  def self.canceled_badge
    { content: I18n.t('interview.status_badge.rejected'),
      class: 'badge badge-danger mb-2'}
  end

  def self.absent_badge
    { content: I18n.t('interview.status_badge.absent'),
      class: 'badge badge-secondary mb-2'}
  end

  def self.done_badge
    { content: I18n.t('interview.status_badge.done'),
      class: 'badge badge-success mb-2'}
  end

end
