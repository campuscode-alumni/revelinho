class Interview < ApplicationRecord
  belongs_to :selection_process

  validates :date, :time_from, :time_to, :address, :format, presence: true

  enum format: { online: 0, face_to_face: 10 }
end
