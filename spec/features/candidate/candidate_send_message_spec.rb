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

    expect(invite.selection_process.messages).to include(text: 'Olá, meu nome'\
                                                               ' é João')
  end
end
