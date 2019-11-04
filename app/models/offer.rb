class Offer < ApplicationRecord
  belongs_to :employee
  belongs_to :selection_process

  belongs_to :message

  delegate :candidate, to: :selection_process
  delegate :position, to: :selection_process

  enum hiring_scheme: { clt: 0, contractor: 5, internship: 10 }
  enum status: { pending: 0, accepted: 5, rejected: 10, canceled: 20 }

  validates :salary, :hiring_scheme, :start_date, presence: true
  validates_associated :message
end
