require 'rails_helper'

RSpec.describe EmployeeMailer, type: :mailer do
  describe '#interview_accepted' do
    it 'should send with proper subject' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published, name: 'John Doe')
      create(:employee, email: 'joao@revelo.com.br', company: company)
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :pending)
      selection_process = invite.create_selection_process
      interview = create(:interview, datetime: '2019-10-26 17:00:00',
                                     format: :face_to_face,
                                     address: 'Av. Paulista, 2000',
                                     selection_process: selection_process)

      mail = EmployeeMailer.interview_accepted(interview.id)
      expect(mail.subject).to eq
      'O candidato John Doe aceitou o convite para a entrevista.'
    end
  end
end
