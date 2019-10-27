class Offer < ApplicationRecord
  belongs_to :employee
  belongs_to :selection_process

  belongs_to :message

  delegate :candidate, to: :selection_process

  enum hiring_scheme: { clt: 0, contractor: 5, internship: 10 }
  enum status: { pending: 0, accepted: 5, canceled: 10 }

  validates :salary, :hiring_scheme, :start_date, :message, presence: true

end
