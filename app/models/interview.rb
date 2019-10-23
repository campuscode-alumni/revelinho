class Interview < ApplicationRecord
  belongs_to :selection_process
  has_many :interview_feedbacks, dependent: :nuliffy

  enum status: { scheduled: 0, done: 5, absent: 10, canceled: 15 }
end
