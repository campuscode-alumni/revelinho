class Invite < ApplicationRecord
  belongs_to :candidate
  belongs_to :position
  has_one :selection_process, dependent: :nullify

  delegate :messages, to: :selection_process

  enum status: { pending: 0, rejected: 5, accepted: 10 }
end
