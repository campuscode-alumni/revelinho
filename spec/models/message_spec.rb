require 'rails_helper'

describe Message do
  context '#create_message' do
    it 'has to create message with sendable' do
      current_employee = create(:employee)
      candidate = create(:candidate)
      position = create(:position, company: current_employee.company)
      invite = Invite.create(candidate: candidate, position: position,
                             status: :accepted)

      invite.create_selection_process

      message = build(:message, sendable: current_employee)

      invite.messages << message

      expect(invite.messages.count).to eq 1
      expect(invite.messages.first.sendable).to eq current_employee
    end
  end
end
