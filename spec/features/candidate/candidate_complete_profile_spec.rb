require 'rails_helper'

feature 'Candidate completes personal profile' do
  scenario 'successfully' do
    candidate = create(:candidate, status: :hidden)
    candidate_profile = build(:candidate_profile)
    login_as(candidate, scope: :candidate)

    visit root_path
    click_on 'Concluir perfil'

    attach_file('Adicione uma foto ao seu perfil',
                Rails.root.join('spec', 'support', 'candidate_avatar.jpeg'))
    fill_in 'Experiência Profissional', with: candidate_profile.work_experience
    fill_in 'Formação', with: candidate_profile.education
    fill_in 'Linguagens de Programação',
            with: candidate_profile.coding_languages
    fill_in 'Habilidades', with: candidate_profile.skills
    fill_in 'Usuário do Skype', with: candidate_profile.skype_username
    fill_in 'LinkedIn', with: candidate_profile.linkedin_profile_url
    fill_in 'GitHub',
            with: candidate_profile.github_profile_url
    fill_in 'Proficiência em Inglês',
            with: candidate_profile.english_proficiency
    click_on 'Atualizar'

    candidate.reload
    expect(page).to have_content(candidate_profile.work_experience)
    expect(page).to have_content(candidate_profile.education)
    expect(page).to have_content(candidate_profile.coding_languages)
    expect(page).to have_content(candidate_profile.skills)
    expect(page).to have_content(candidate_profile.skype_username)
    expect(page).to have_content(candidate_profile.linkedin_profile_url)
    expect(page).to have_content(candidate_profile.github_profile_url)
    expect(page).to have_content(candidate_profile.english_proficiency)
    expect(page).to have_css('img[src*="candidate_avatar.jpeg"]')
    candidate.reload
    expect(candidate).to be_published
  end

  scenario 'and must be logged in to click link' do
    visit root_path

    expect(page).not_to have_link('Concluir perfil')
  end

  scenario 'and must fill in required fields' do
    candidate = create(:candidate, status: :hidden)
    login_as(candidate, scope: :candidate)

    visit root_path
    click_on 'Concluir perfil'

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

  scenario 'and must be logged in' do
    visit new_candidate_profile_path

    expect(current_path).to eq new_candidate_session_path
  end

  scenario 'and profile is already published' do
    candidate = create(:candidate)
    create(:candidate_profile, candidate: candidate)
    login_as(candidate, scope: :candidate)

    visit root_path

    expect(page).to have_content('Seu perfil está ativo.')
    expect(page).not_to have_link('Concluir perfil')
  end

  scenario 'and cannot be already logged in as employee' do
    candidate = create(:candidate)
    login_as(candidate, scope: :candidate)
    create(:employee, email: 'teste@example.com', password: '123456')

    visit new_employee_session_path
    fill_in 'Email', with: 'teste@example.com'
    fill_in 'Senha', with: '123456'
    click_on 'Login'

    expect(current_path).to eq root_path
    expect(page).to have_content(I18n.t('error_messages.duplicated_login'))
  end

  scenario 'and is able to see his own profile' do
    candidate = create(:candidate, status: :published)
    create(:candidate_profile, candidate: candidate)

    login_as(candidate, scope: :candidate)

    visit root_path
    click_on 'Candidato'
    click_on 'Ver perfil'

    expect(current_path).to eq(my_profile_candidates_path)
  end
end
