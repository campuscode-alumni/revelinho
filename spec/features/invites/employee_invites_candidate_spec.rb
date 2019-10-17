require 'rails_helper'

feature 'Invites' do
  scenario 'Employee invites candidate to position' do
<<<<<<< HEAD
    company = create(:company, :active, url_domain: 'revelo.com.br')
    employee = create(:employee, email: 'renata@revelo.com.br')
    candidate = create(:candidate)
    create(:candidate_profile, candidate: candidate)
    create(:position, title: 'Engenheiro de Software Pleno',
                      company: company)

    login_as(employee, scope: :employee)
    visit candidate_path(candidate)
=======
    employee = create(:employee)
    candidate = create(:candidate)
    create(:candidate_profile, candidate: candidate)
    create(:position, title: 'Engenheiro de Software Pleno')

    login_as(employee, scope: :employee)
    visit candidate
>>>>>>> 7df2dd4... add invite model and tests

    select 'Engenheiro de Software Pleno', from: 'Posição'
    fill_in 'Mensagem', with: 'Olá, ser humano. Venha fazer parte do nosso time'
    click_on 'Enviar convite'

    candidate.reload
    expect(page).to have_content('Gustavo convidado com sucesso para ' \
    'Engenheiro de Software Pleno')
    expect(candidate.invites.count).to eq(1)
    expect(current_path).to eq(candidates_path)
  end

  scenario 'Employee sees invited candidates in candidates list' do
    employee = create(:employee)
    candidate = create(:candidate)
    create(:candidate_profile, candidate: candidate)
    position = create(:position, title: 'Engenheiro de Software Pleno')
    create(
      :invite,
      candidate: candidate,
      position: position,
      message: 'Olá, ser humano. Venha fazer parte do nosso time'
    )

    login_as(employee, scope: :employee)
    visit candidates_path

    within "#candidate-#{candidate.id}" do
      expect(page).to have_content('Aguardando aceite de convite')
    end
  end

  scenario 'Employee sees existing invite in candidate page' do
    employee = create(:employee)
    candidate = create(:candidate)
    create(:candidate_profile, candidate: candidate)
    position = create(:position, title: 'Engenheiro de Software Pleno')
    create(
      :invite,
      candidate: candidate,
      position: position,
      message: 'Olá, ser humano. Venha fazer parte do nosso time'
    )

    login_as(employee, scope: :employee)
<<<<<<< HEAD
    visit candidate_path(candidate)
=======
    visit candidate
>>>>>>> 7df2dd4... add invite model and tests

    expect(page).to have_content('Candidato convidado para:')
    expect(page).to have_content(position.title)
  end
end
