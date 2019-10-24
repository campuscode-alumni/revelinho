require 'rails_helper'

feature 'candidate accept interview' do
  scenario 'successfully' do
    company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
    candidate = create(:candidate, status: :published)
    create(:employee, email: 'joao@revelo.com.br', company: company)
    position = create(:position, company: company)
    invite = create(:invite, candidate: candidate, position: position,
                             status: :pending)
    selection_process = invite.create_selection_process
    create(:interview, datetime: '2019-10-26 17:00:00',
                       format: :face_to_face,
                       address: 'Av. Paulista, 2000',
                       selection_process: selection_process)

    login_as(candidate, scope: :candidate)
    visit selection_process_candidates_path(selection_process)

    expect(page).to have_content('Entrevistas')
    expect(page).to have_content('Dia 26/10/2019 às 17:00')
    expect(page).to have_content('Endereço: Av. Paulista, 2000')
    expect(page).to have_content('Formato: presencial')
    expect(page).to have_link('Aceitar')
    expect(page).to have_link('Recusar')
  end
end
