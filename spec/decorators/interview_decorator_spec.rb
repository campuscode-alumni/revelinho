require 'rails_helper'

describe InterviewDecorator do
  context '#format_datetime' do
    it 'shows datetime formated correctly' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published)
      create(:employee, email: 'joao@revelo.com.br', company: company)
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :pending)
      selection_process = invite.create_selection_process
      interview = create(:interview,
                         datetime: '2019-10-26 17:00:00',
                         format: :face_to_face,
                         address: 'Av. Paulista, 2000',
                         selection_process: selection_process).decorate

      expect(interview.formatting_datetime).to eq '26 de outubro de 2019, 17:00'
    end
  end
  context '#interview_address' do
    it 'shows address correctly' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published)
      create(:employee, email: 'joao@revelo.com.br', company: company)
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :pending)
      selection_process = invite.create_selection_process
      interview = create(:interview,
                         datetime: '2019-10-26 17:00:00',
                         format: :face_to_face,
                         address: 'Av. Paulista, 2000',
                         selection_process: selection_process).decorate

      expect(interview.interview_address).to eq 'Endereço: Av. Paulista, 2000'
    end
  end
  context '#interview_address' do
    it 'shows address correctly' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published)
      create(:employee, email: 'joao@revelo.com.br', company: company)
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :pending)
      selection_process = invite.create_selection_process
      interview = create(:interview,
                         datetime: '2019-10-26 17:00:00',
                         format: :face_to_face,
                         address: 'Av. Paulista, 2000',
                         selection_process: selection_process).decorate

      expect(interview.interview_format).to eq 'Formato: Presencial'
    end
  end
  context '#footer' do
    it 'shows decision buttons if invite is pending and a it is a candidate' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published)
      create(:employee, email: 'joao@revelo.com.br', company: company)
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :pending)
      login_as(candidate, scope: :candidate)
      selection_process = invite.create_selection_process
      interview = create(:interview,
                         datetime: '2019-10-26 17:00:00',
                         format: :face_to_face,
                         address: 'Av. Paulista, 2000',
                         selection_process: selection_process,
                         status: :pending).decorate(candidate)

      expect(interview.footer).to(include 'Aceitar')
      expect(interview.footer).to(include 'Recusar')
    end
    it 'do not shows buttons if invite is not pending and it is a candidate' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published)
      create(:employee, email: 'joao@revelo.com.br', company: company)
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :pending)
      login_as(candidate, scope: :candidate)
      selection_process = invite.create_selection_process
      interview = create(:interview, datetime: '2019-10-26 17:00:00',
                                     format: :face_to_face,
                                     address: 'Av. Paulista, 2000',
                                     selection_process: selection_process,
                                     status: :scheduled).decorate(candidate)

      expect(interview.footer).to eq ''
    end
  end
  context '#interview_status_badge' do
    it 'shows pending_badge correctly' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published)
      create(:employee, email: 'joao@revelo.com.br', company: company)
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :pending)
      selection_process = invite.create_selection_process
      interview = create(:interview,
                         datetime: '2019-10-26 17:00:00',
                         format: :face_to_face,
                         address: 'Av. Paulista, 2000',
                         selection_process: selection_process,
                         status: :pending).decorate

      expect(interview.interview_status_badge).to(
        include 'Aguardando resposta'
      )
      expect(interview.interview_status_badge).not_to(
        include('Entrevista agendada', 'Entrevista cancelada')
      )
    end
    it 'shows scheduled_badge correctly' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published)
      create(:employee, email: 'joao@revelo.com.br', company: company)
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :pending)
      selection_process = invite.create_selection_process
      interview = create(:interview,
                         datetime: '2019-10-26 17:00:00',
                         format: :face_to_face,
                         address: 'Av. Paulista, 2000',
                         selection_process: selection_process,
                         status: :scheduled).decorate

      expect(interview.interview_status_badge).to(
        include 'Entrevista agendada'
      )
      expect(interview.interview_status_badge).not_to(
        include('Aguardando resposta', 'Entrevista cancelada')
      )
    end
    it 'shows canceled_badge correctly' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published)
      create(:employee, email: 'joao@revelo.com.br', company: company)
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :pending)
      selection_process = invite.create_selection_process
      interview = create(:interview,
                         datetime: '2019-10-26 17:00:00',
                         format: :face_to_face,
                         address: 'Av. Paulista, 2000',
                         selection_process: selection_process,
                         status: :canceled).decorate

      expect(interview.interview_status_badge).to(
        include 'Entrevista cancelada'
      )
      expect(interview.interview_status_badge).not_to(
        include('Entrevista agendada', 'Aguardando resposta')
      )
    end
  end
end
