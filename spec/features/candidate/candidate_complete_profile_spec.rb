require 'rails_helper'

feature 'Candidate completes personal profile' do
  scenario 'successfully' do
    candidate = create(:candidate, status: :hidden)
    login_as(candidate, scope: :candidate)

    visit root_path
    click_on 'Concluir perfil'

    fill_in 'Experiência Profissional', with: 'Revelo'
    fill_in 'Formação', with: 'Faculdade X'
    fill_in 'Linguagens de Programação', with: 'Ruby'
    fill_in 'Habilidades', with: 'Scrum'
    fill_in 'Proficiência em Inglês', with: 'Fluente'
    fill_in 'Usuário do Skype', with: 'candidate.skype'
    fill_in 'LinkedIn', with: 'https://www.linkedin.com/in/candidate'
    fill_in 'GitHub', with: 'https://github.com/candidate'
    click_on 'Atualizar Perfil'

    expect(page).to have_content('Revelo')
    expect(page).to have_content('Faculdade X')
    expect(page).to have_content('Ruby')
    expect(page).to have_content('Scrum')
    expect(page).to have_content('candidate.skype')
    expect(page).to have_content('https://www.linkedin.com/in/candidate')
    expect(page).to have_content('https://github.com/candidate')
    expect(page).to have_content('Fluente')
    candidate.reload
    expect(candidate).to be_published
  end

  scenario 'and must be logged in' do
    visit root_path

    expect(page).not_to have_link('Concluir perfil')
  end
end
