require 'rails_helper'

describe InviteMailer do
  describe '#notify_candidate' do
    it 'should send with proper subject' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      create(:employee, email: 'renata@revelo.com.br', company: company)
      candidate = create(:candidate, name: 'Gustavo',
                                     email: 'gustavo@email.com')
      create(:candidate_profile, candidate: candidate)
      position = create(:position, title: 'Engenheiro de Software Pleno',
                                   company: company)
      invite = create(
        :invite,
        candidate: candidate,
        position: position,
        message: 'Olá, ser humano. Venha fazer parte do nosso time'
      )

      mail = InviteMailer.notify_candidate(invite.id)
      expect(mail.subject).to eq 'Gustavo, você foi convidado ' \
                                 'para uma posição na Revelo'
    end

    it 'should send to candidate email' do
      company = create(:company, name: 'Revelo',
                                 url_domain: 'revelo.com.br')
      create(:employee, email: 'renata@revelo.com.br',
                        company: company)
      candidate = create(:candidate, name: 'Gustavo',
                                     email: 'gustavo@email.com')
      create(:candidate_profile, candidate: candidate)
      position = create(:position, title: 'Engenheiro de Software Pleno',
                                   company: company)
      invite = create(
        :invite,
        candidate: candidate,
        position: position,
        message: 'Olá, ser humano. Venha fazer parte do nosso time'
      )

      mail = InviteMailer.notify_candidate(invite.id)
      expect(mail.to).to include 'gustavo@email.com'
    end

    it 'should have an invitation message' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      create(:employee, email: 'renata@revelo.com.br',
                        company: company)
      candidate = create(:candidate, name: 'Gustavo',
                                     email: 'gustavo@email.com')
      create(:candidate_profile, candidate: candidate)
      position = create(:position, title: 'Engenheiro de Software Pleno',
                                   company: company)
      invite = create(
        :invite,
        candidate: candidate,
        position: position,
        message: 'Olá, ser humano. Venha fazer parte do nosso time'
      )

      mail = InviteMailer.notify_candidate(invite.id)
      expect(mail.body).to include 'Revelo te convidou para a posição de ' \
                                   'Engenheiro de Software Pleno'
      expect(mail.body).to include invites_candidates_url
    end
  end
end
