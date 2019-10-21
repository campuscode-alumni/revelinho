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

    expect(page).to have_css('h4', text: candidate.email)
    expect(page).to have_content('Olá, meu nome é João')
  end

  scenario 'and validate empty field' do
    candidate = create(:candidate, status: :published)
    position = create(:position, :with_company, title: 'Desenvolvedor')
    invite = create(:invite, candidate: candidate,
                             position: position, status: :accepted)
    invite.create_selection_process

    login_as(candidate, scope: :candidate)
    visit selection_process_candidates_path(invite.selection_process)

    fill_in 'Mensagem', with: ''
    click_on('Enviar')

    expect(page).to have_content('Não foi possivel enviar mensagem.'\
                                 ' Tente novamente')
  end
end
