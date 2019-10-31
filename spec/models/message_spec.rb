require 'rails_helper'

describe Message do
  context 'candidate' do
    context '#create_message' do
      it 'has to create message with sendable' do
        current_candidate = create(:candidate, status: :published)
        position = create(:position)
        invite = create(:invite, candidate: current_candidate,
                                 position: position, status: :accepted)

        invite.create_selection_process

        message = build(:message, sendable: current_candidate)

        invite.messages << message

        expect(invite.messages.count).to eq 1
        expect(invite.messages.first.sendable).to eq current_candidate
      end
    end
  end

  context 'employee' do
    context '#create_message' do
      it 'has to create message with sendable' do
        current_employee = create(:employee)
        candidate = create(:candidate)
        position = create(:position, company: current_employee.company)
        invite = create(:invite, candidate: candidate, position: position,
                                 status: :accepted)

        invite.create_selection_process

        invite.messages << build(:message, sendable: current_employee)

        expect(invite.messages.count).to eq 1
        expect(invite.messages.first.sendable).to eq current_employee
      end
    end
  end
end
