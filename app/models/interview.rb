class Interview < ApplicationRecord
  belongs_to :selection_process

  enum format: { online: 0, face_to_face: 10 }
  attr_accessor :date, :time, :hour, :minutes
end
