require 'rails_helper'

describe OfferMailer, type: :mailer do
  describe '#notify_candidate' do
    it 'should send with proper subject' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      employee = create(:employee, email: 'joao.silva@revelo.com.br',
                                   company: company)
      candidate = create(:candidate, name: 'José', email: 'jose@email.com')
      create(:candidate_profile, candidate: candidate)
      position = create(:position, title: 'Desenvolvedor', company: company)
      invite = create(
        :invite,
        candidate: candidate,
        position: position,
        message: 'Olá, ser humano. Venha fazer parte do nosso time'
      )
      invite.create_selection_process
      message = create(:message, text: 'Podemos contar com você na equipe?',
                                 selection_process: invite.selection_process,
                                 sendable: employee)
      create(:offer, salary: 2500.00, hiring_scheme: :clt, message: message,
                     start_date: 15.days.from_now, employee: employee,
                     selection_process: invite.selection_process)

      mail = OfferMailer.notify_candidate(Offer.last.id)
      expect(mail.subject).to eq 'Você recebeu uma proposta para a posição'\
                                 ' Desenvolvedor'
    end

    it 'should send to candidate email' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      employee = create(:employee, email: 'joao.silva@revelo.com.br',
                                   company: company)
      candidate = create(:candidate, name: 'José', email: 'jose@email.com')
      create(:candidate_profile, candidate: candidate)
      position = create(:position, title: 'Desenvolvedor', company: company)
      invite = create(
        :invite,
        candidate: candidate,
        position: position,
        message: 'Olá, ser humano. Venha fazer parte do nosso time'
      )
      invite.create_selection_process
      message = create(:message, text: 'Podemos contar com você na equipe?',
                                 selection_process: invite.selection_process,
                                 sendable: employee)
      create(:offer, salary: 2500.00, hiring_scheme: :clt, message: message,
                     start_date: 15.days.from_now, employee: employee,
                     selection_process: invite.selection_process)

      mail = OfferMailer.notify_candidate(Offer.last.id)
      expect(mail.to).to include('jose@email.com')
    end
  end
end
