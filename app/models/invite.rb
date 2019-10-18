class Invite < ApplicationRecord
  belongs_to :candidate, dependent: :destroy
  belongs_to :position, dependent: :destroy

  enum status: { pending: 0, rejected: 5, accepted: 10 }
end
