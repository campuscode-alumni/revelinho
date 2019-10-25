class SelectionProcess < ApplicationRecord
  belongs_to :invite
  delegate :position, to: :invite
  delegate :company, to: :position
  delegate :company_profile, to: :company

  has_many :messages, dependent: :destroy
  has_many :interviews, dependent: :destroy
end
