class InterviewFeedback < ApplicationRecord
  belongs_to :interview
  belongs_to :employee

  validates :message, presence: true
end
