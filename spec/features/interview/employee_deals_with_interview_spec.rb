require 'rails_helper'

feature 'employee sees interview invite' do
  scenario 'successfully' do
    company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
    company.company_profile = create(:company_profile)
    candidate = create(:candidate, status: :published)
    employee = create(:employee, email: 'joao@revelo.com.br', company: company)
    position = create(:position, company: company)
    invite = create(:invite, candidate: candidate, position: position,
                             status: :accepted)
    selection_process = invite.create_selection_process
    create(:interview, date: '2019-10-26',
                       time_from: '17:00',
                       time_to: '18:00',
                       format: :face_to_face,
                       status: :pending,
                       address: 'Av. Paulista, 2000',
                       selection_process: selection_process)

    login_as(employee, scope: :employee)
    visit selection_process_candidates_path(selection_process)

    expect(page).to have_content('Entrevistas')
    expect(page).to have_content('26 de outubro de 2019')
    expect(page).to have_content('das 17:00')
    expect(page).to have_content('às 18:00')
    expect(page).to have_content('Endereço: Av. Paulista, 2000')
    expect(page).to have_content('Formato: Presencial')
    expect(page).to have_content('Aguardando resposta')
    expect(page).not_to have_link('Aceitar')
    expect(page).not_to have_link('Recusar')
  end

  scenario 'and changes its status' do
    company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
    company.company_profile = create(:company_profile)
    candidate = create(:candidate, :with_candidate_profile, status: :published)
    employee = create(:employee, email: 'joao@revelo.com.br', company: company)
    position = create(:position, company: company)
    invite = create(:invite, candidate: candidate, position: position,
                             status: :accepted)
    selection_process = invite.create_selection_process
    create(:interview, date: '2019-10-26',
                       time_from: '17:00',
                       time_to: '18:00',
                       format: :face_to_face,
                       address: 'Av. Paulista, 2000',
                       status: :absent,
                       selection_process: selection_process)

    login_as(employee, scope: :employee)
    visit selection_process_candidates_path(selection_process)

    click_on 'Realizada'

    expect(page).to have_content('26 de outubro de 2019, das 17:00 às 18:00')
    expect(page).to have_content('Endereço: Av. Paulista, 2000')
    expect(page).to have_content('Formato: Presencial')
    expect(page).to have_content('Entrevista realizada')
    expect(page).not_to have_content('Aguardando resposta')
    expect(page).to have_link('Feedbacks')
    expect(page).not_to have_link('Aceitar')
    expect(page).not_to have_link('Recusar')
  end

  scenario 'and sees the feedback button' do
    company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
    company.company_profile = create(:company_profile)
    candidate = create(:candidate, :with_candidate_profile, status: :published)
    employee = create(:employee, email: 'joao@revelo.com.br', company: company)
    position = create(:position, company: company)
    invite = create(:invite, candidate: candidate, position: position,
                             status: :accepted)
    selection_process = invite.create_selection_process
    create(:interview, date: '2019-10-26',
                       time_from: '17:00',
                       time_to: '18:00',
                       format: :face_to_face,
                       status: :done,
                       address: 'Av. Paulista, 2000',
                       selection_process: selection_process)

    login_as(employee, scope: :employee)
    visit selection_process_candidates_path(selection_process)

    expect(page).to have_link('Feedbacks')
    expect(page).to have_link('Marcar como')
    expect(page).not_to have_link('Aceitar')
    expect(page).not_to have_link('Recusar')
  end
end
