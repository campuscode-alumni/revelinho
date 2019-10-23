class Interview < ApplicationRecord
  belongs_to :selection_process
  has_many :interview_feedbacks, dependent: :nuliffy
end
