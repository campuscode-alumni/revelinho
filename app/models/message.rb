class Message < ApplicationRecord
  belongs_to :selection_process
  belongs_to :sendable, polymorphic: true

  validates :text, presence: true

  enum message_type: { chat: 0, new_interview: 5, interview_accepted: 10,
                       interview_rejected: 15, new_offer: 20,
                       offer_accepted: 25, offer_rejected: 30 }
end
