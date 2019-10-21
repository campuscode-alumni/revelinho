require 'rails_helper'

feature 'candidate send message' do
  scenario 'successfully' do
    candidate = create(:candidate, status: :published)
    position = create(:position, :with_company)
    invite = create(:invite, candidate: candidate,
                             position: position,
                             status: :pending)

    login_as(candidate, scope: :candidate)
    visit invites_candidates_path

    click_link('Aceitar')

    fill_in 'Mensagem', with: 'Olá, meu nome é João'
    click_on('Enviar')

    message = invite.messages.first
    expect(message.text).to eq 'Olá, meu nome é João'
    expect(message.sendable).to eq candidate
  end
end
