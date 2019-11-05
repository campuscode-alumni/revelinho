class InterviewFeedback < ApplicationRecord
  belongs_to :interview
  belongs_to :employee, polymorphic: true

  validates :message, presence: true
end
