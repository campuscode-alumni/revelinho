require 'rails_helper'

describe Message do
  context '#create_message' do
    it 'has to create message with sendable' do
      current = create(:employee)
      candidate = create(:candidate)
      position = create(:position, company: current.company)
      invite = Invite.create(candidate: candidate, position: position,
                             status: :accepted)

      invite.create_selection_process

      message = build(:message, sendable: current)

      invite.messages << message

      expect(invite.messages.count).to eq 1
      expect(invite.messages.first.sendable).to eq current
    end
  end
end
