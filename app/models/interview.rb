class Interview < ApplicationRecord
  belongs_to :selection_process
  delegate :invite, to: :selection_process
  delegate :position, to: :invite
  delegate :candidate, to: :invite

  validates :date, :time_from, :time_to, :address, :format, presence: true

  enum status: { pending: 0, scheduled: 5, done: 10, absent: 15, canceled: 20 }
  enum format: { online: 0, face_to_face: 10 }
end
