require 'rails_helper'

describe 'Interview' do
  context 'accept' do
    it 'candidate cannot accept rejected interview' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published)
      create(:employee, email: 'joao@revelo.com.br', company: company)
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :pending)
      selection_process = invite.create_selection_process
      interview = create(:interview, date: '2019-10-26',
                                     time_from: '17:00',
                                     time_to: '18:00',
                                     format: :face_to_face,
                                     address: 'Av. Paulista, 2000',
                                     selection_process: selection_process,
                                     status: :canceled)

      login_as(candidate, scope: :candidate)
      post accept_interview_candidate_path(interview)

      interview.reload
      expect(interview.status).to eq 'canceled'
    end
  end
  context 'reject' do
    it 'candidate cannot reject accepted interview' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published)
      create(:employee, email: 'joao@revelo.com.br', company: company)
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :pending)
      selection_process = invite.create_selection_process
      interview = create(:interview, date: '2019-10-26',
                                     time_from: '17:00',
                                     time_to: '18:00',
                                     format: :face_to_face,
                                     address: 'Av. Paulista, 2000',
                                     selection_process: selection_process,
                                     status: :scheduled)

      login_as(candidate, scope: :candidate)
      post reject_interview_candidate_path(interview)

      interview.reload
      expect(interview.status).to eq 'scheduled'
    end
  end
end
