require 'rails_helper'

feature 'Candidate edits personal profile' do
  scenario 'successfully' do
    candidate = create(:candidate)
    create(:candidate_profile, candidate: candidate)
    login_as(candidate, scope: :candidate)

    visit dashboard_candidates_path
    click_on 'Editar Perfil'

    fill_in 'Experiência Profissional', with: 'Campus Code'
    fill_in 'Formação', with: 'Faculdade Y'
    fill_in 'Linguagens de Programação',
            with: 'Java'
    fill_in 'Habilidades', with: 'Kanban'
    fill_in 'Usuário do Skype', with: 'skype_other_candidate'
    fill_in 'LinkedIn', with: 'https://www.linkedin.com/in/other_candidate'
    fill_in 'GitHub',
            with: 'https://www.github.com/other_candidate'
    fill_in 'Proficiência em Inglês',
            with: 'Avançado'
    click_on 'Atualizar'

    expect(page).to have_content('Campus Code')
    expect(page).to have_content('Faculdade Y')
    expect(page).to have_content('Java')
    expect(page).to have_content('Kanban')
    expect(page).to have_content('skype_other_candidate')
    expect(page).to have_content('https://www.linkedin.com/in/other_candidate')
    expect(page).to have_content('https://www.github.com/other_candidate')
    expect(page).to have_content('Avançado')
    candidate.reload
    expect(candidate).to be_published
  end

  scenario 'and must fill in required fields' do
    candidate = create(:candidate)
    create(:candidate_profile, candidate: candidate)

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Editar Perfil'

    fill_in 'Experiência Profissional', with: ''
    fill_in 'Formação', with: ''
    fill_in 'Habilidades', with: ''
    fill_in 'Usuário do Skype', with: ''
    fill_in 'LinkedIn', with: ''
    fill_in 'GitHub', with: ''
    fill_in 'Proficiência em Inglês', with: ''
    click_on 'Atualizar'

    expect(page).to have_content('Experiência Profissional '\
                                 'não pode ficar em branco')
    expect(page).to have_content('Formação não pode ficar em branco')
    expect(page).to have_content('Habilidades não pode ficar em branco')
    expect(page).to have_content('Usuário do Skype não pode ficar em branco')
    expect(page).to have_content('LinkedIn não pode ficar em branco')
    expect(page).to have_content('GitHub não pode ficar em branco')
    expect(page).to have_content('Proficiência em Inglês não '\
                                 'pode ficar em branco')
  end
end
