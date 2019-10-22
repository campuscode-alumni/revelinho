class SelectionProcess < ApplicationRecord
  belongs_to :invite
  delegate :position, to: :invite
  delegate :company, to: :position

  has_many :messages, dependent: :destroy
  has_many :interviews, dependent: :destroy
end
