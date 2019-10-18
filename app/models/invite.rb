class Invite < ApplicationRecord
  belongs_to :candidate, dependent: :destroy
  belongs_to :position, dependent: :destroy
  has_one :selection_process, dependent: :destroy

  enum status: { pending: 0, rejected: 5, accepted: 10 }
end
