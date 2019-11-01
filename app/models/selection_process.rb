class SelectionProcess < ApplicationRecord
  belongs_to :invite
  delegate :candidate, to: :invite
  delegate :employee, to: :invite
  delegate :position, to: :invite
  delegate :company, to: :position
  delegate :company_profile, to: :company

  has_many :messages, dependent: :nullify
  has_many :interviews, dependent: :nullify
  has_many :offers, dependent: :nullify
end
