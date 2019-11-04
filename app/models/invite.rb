class Invite < ApplicationRecord
  belongs_to :candidate
  belongs_to :position
  belongs_to :employee
  has_one :selection_process, dependent: :nullify
  has_many :interviews, through: :selection_process

  delegate :messages, to: :selection_process
  delegate :company, to: :position
  delegate :company_profile, to: :company

  enum status: { pending: 0, rejected: 5, accepted: 10 }
end
