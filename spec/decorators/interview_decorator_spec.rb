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
                         date: '2019-10-26',
                         time_from: '17:00',
                         time_to: '18:00',
                         format: :face_to_face,
                         address: 'Av. Paulista, 2000',
                         selection_process: selection_process).decorate

      expect(interview.formatting_datetime).to eq '26 de outubro de 2019, ' \
        'das 17:00 às 18:00'
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
                         date: '2019-10-26',
                         time_from: '17:00',
                         time_to: '18:00',
                         format: :face_to_face,
                         address: 'Av. Paulista, 2000',
                         selection_process: selection_process).decorate

      expect(interview.interview_address).to eq 'Endereço: Av. Paulista, 2000'
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
      selection_process = invite.create_selection_process
      interview = create(:interview,
                         date: '2019-10-26',
                         time_from: '17:00',
                         time_to: '18:00',
                         format: :face_to_face,
                         address: 'Av. Paulista, 2000',
                         selection_process: selection_process,
                         status: :pending).decorate

      footer = interview.footer candidate
      expect(footer).to(include 'Aceitar')
      expect(footer).to(include 'Recusar')
    end
    it 'do not shows buttons if invite is not pending and it is a candidate' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published)
      create(:employee, email: 'joao@revelo.com.br', company: company)
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :accepted)
      selection_process = invite.create_selection_process
      interview = create(:interview,
                         date: '2019-10-26',
                         time_from: '17:00',
                         time_to: '18:00',
                         format: :face_to_face,
                         address: 'Av. Paulista, 2000',
                         selection_process: selection_process,
                         status: :scheduled).decorate

      expect(interview.footer candidate).to eq ''
    end
    it 'shows status picker if it is a employee' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published)
      employee = create(:employee, email: 'joao@revelo.com.br',
                                   company: company)
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
                                     status: :scheduled).decorate

      footer = interview.footer employee
      expect(footer).to include 'Realizada'
      expect(footer).to include 'Agendada'
      expect(footer).to include 'Pendente'
      expect(footer).to include 'Ausente'
      expect(footer).to include 'Cancelada'
      expect(footer).to include 'Marcar'
    end
    it 'shows feedback button if it is done and if it is a employee' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published)
      employee = create(:employee, email: 'joao@revelo.com.br',
                                   company: company)
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
                                     status: :done).decorate

      footer = interview.footer employee
      expect(footer).to include 'Pendente'
      expect(footer).to include 'Realizada'
      expect(footer).to include 'Agendada'
      expect(footer).to include 'Ausente'
      expect(footer).to include 'Cancelada'
      expect(footer).to include 'Marcar'
      expect(footer).to include 'Feedbacks'
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
                         date: '2019-10-26',
                         time_from: '17:00',
                         time_to: '18:00',
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
                         date: '2019-10-26',
                         time_from: '17:00',
                         time_to: '18:00',
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
                         date: '2019-10-26',
                         time_from: '17:00',
                         time_to: '18:00',
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
  context '#status_buttons' do
    it 'shows status links' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published)
      employee = create(:employee, email: 'joao@revelo.com.br',
                                   company: company)
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
                                     status: :done).decorate

      status_buttons = interview.status_buttons
      expect(status_buttons).to include 'Pendente'
      expect(status_buttons).to include 'Realizada'
      expect(status_buttons).to include 'Agendada'
      expect(status_buttons).to include 'Ausente'
      expect(status_buttons).to include 'Cancelada'
    end
  end
end
