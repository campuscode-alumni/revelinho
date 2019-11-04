require 'rails_helper'

RSpec.describe InterviewMailer, type: :mailer do
  describe '#interview_accepted' do
    it 'should send with proper subject' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published, name: 'John Doe')
      employee = create(:employee, email: 'joao@revelo.com.br',
                                   company: company)
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :pending, employee: employee)
      selection_process = invite.create_selection_process
      interview = create(:interview, date: '2019-10-26',
                                     time_from: '17:00',
                                     time_to: '17:30',
                                     format: :face_to_face,
                                     address: 'Av. Paulista, 2000',
                                     selection_process: selection_process)

      mail = InterviewMailer.interview_accepted(interview.id)
      expect(mail.subject).to(
        eq 'O candidato John Doe aceitou o convite para a entrevista.'
      )
    end
    it 'should send to employee email' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published, name: 'John Doe')
      employee = create(:employee, email: 'joao@revelo.com.br',
                                   company: company)
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :pending, employee: employee)
      selection_process = invite.create_selection_process
      interview = create(:interview, date: '2019-10-26',
                                     time_from: '17:00',
                                     time_to: '17:30',
                                     format: :face_to_face,
                                     address: 'Av. Paulista, 2000',
                                     selection_process: selection_process)

      mail = InterviewMailer.interview_accepted(interview.id)
      expect(mail.to).to(
        include 'joao@revelo.com.br'
      )
    end
    it 'should have the right email body' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published, name: 'John Doe')
      employee = create(:employee, email: 'joao@revelo.com.br',
                                   company: company)
      position = create(:position, company: company, title: 'Dev ruby')
      invite = create(:invite, candidate: candidate, position: position,
                               status: :pending, employee: employee)
      selection_process = invite.create_selection_process
      interview = create(:interview, date: '2019-10-26',
                                     time_from: '17:00',
                                     time_to: '17:30',
                                     format: :face_to_face,
                                     address: 'Av. Paulista, 2000',
                                     selection_process: selection_process)

      mail = InterviewMailer.interview_accepted(interview.id)
      expect(mail.body).to include('John Doe')
      expect(mail.body).to include('Av. Paulista, 2000')
      expect(mail.body).to include('Dev ruby')
      expect(mail.body).to include('26 de outubro de 2019')
      expect(mail.body).to include(
        selection_process_candidates_url(selection_process).to_s
      )
      expect(mail.body).to include('17:00')
      expect(mail.body).to include('17:30')
    end
  end
end
