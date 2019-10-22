require 'rails_helper'

describe CandidateNoteDecorator do
  context '#sent_by' do
    it 'shows employee username' do
      employee = create(:employee, email: 'lucas@revelo.com')
      candidate_note = create(:candidate_note, employee: employee).decorate

      expect(candidate_note.sent_by).to eq '@lucas'
    end
  end
end
