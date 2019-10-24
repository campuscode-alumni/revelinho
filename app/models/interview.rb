class Interview < ApplicationRecord
  belongs_to :selection_process
  has_many :interview_feedbacks, dependent: :nuliffy

  enum status: { pending: 0, scheduled: 5, done: 10, absent: 15, canceled: 20 }
end
