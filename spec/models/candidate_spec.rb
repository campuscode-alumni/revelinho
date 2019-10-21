require 'rails_helper'

describe Candidate do
  context '#invited_positions' do
    it 'has to show invited positions' do
      company = create(:company, :active, url_domain: 'revelo.com.br')
      candidate = create(:candidate)
      create(:candidate_profile, candidate: candidate)
      position = create(:position, company: company)
      position_uninvited = create(:position, company: company)
      create(:invite, candidate: candidate, position: position)

      invited_positions = candidate.invited_positions(company)

      expect(invited_positions.count).to eq 1
      expect(invited_positions).to include position
      expect(invited_positions).not_to include position_uninvited
    end
  end

  context '#uninvited_positions' do
    it 'has to show uninvited positions' do
      company = create(:company, :active, url_domain: 'revelo.com.br')
      candidate = create(:candidate)
      create(:candidate_profile, candidate: candidate)
      position = create(:position, company: company)
      position_uninvited = create(:position, company: company)
      create(:invite, candidate: candidate, position: position)

      uninvited_positions = candidate.uninvited_positions(company)

      expect(uninvited_positions.count).to eq 1
      expect(uninvited_positions).not_to include position
      expect(uninvited_positions).to include position_uninvited
    end
  end
end
