require 'rails_helper'

feature 'Candidate completes personal profile' do
  scenario 'successfully' do
    candidate = create(:candidate, status: :hidden)
    candidate_profile = build(:candidate_profile)
    login_as(candidate, scope: :candidate)

    visit root_path
    click_on 'Concluir perfil'

    fill_in 'Experiência Profissional', with: candidate_profile.work_experience
    fill_in 'Formação', with: candidate_profile.education
    fill_in 'Linguagens de Programação', with: candidate_profile.coding_languages
    fill_in 'Habilidades', with: candidate_profile.skills
    fill_in 'Usuário do Skype', with: candidate_profile.skype_username
    fill_in 'Linkedin', with: candidate_profile.linkedin_profile_url
    fill_in 'Git', with: candidate_profile.github_profile_url
    fill_in 'Proficiência em Inglês', with: candidate_profile.english_proficiency
    click_on 'Atualizar'

    expect(page).to have_content(candidate_profile.work_experience)
    expect(page).to have_content(candidate_profile.education)
    expect(page).to have_content(candidate_profile.coding_languages)
    expect(page).to have_content(candidate_profile.skills)
    expect(page).to have_content(candidate_profile.skype_username)
    expect(page).to have_content(candidate_profile.linkedin_profile_url)
    expect(page).to have_content(candidate_profile.github_profile_url)
    expect(page).to have_content(candidate_profile.english_proficiency)
    candidate.reload
    expect(candidate).to be_published
  end

  scenario 'and must fill in required fields' do
    candidate = create(:candidate)
    login_as(candidate, scope: :candidate)

    visit root_path
    click_on 'Concluir perfil'

    fill_in 'Experiência profissional', with: ''
    fill_in 'Formação', with: ''
    fill_in 'Habilidades', with: ''
    fill_in 'Usuário do Skype', with: ''
    fill_in 'Linkedin', with: ''
    fill_in 'Git', with: ''
    fill_in 'Proficiência em Inglês', with: ''
    click_on 'Atualizar'

    expect(page).to have_content('Experiência Profissional'\
                                 'não pode ficar em branco')
    expect(page).to have_content('Formação não pode ficar em branco')
    expect(page).to have_content('Habilidades não pode ficar em branco')
    expect(page).to have_content('Usuário do Skype não pode ficar em branco')
    expect(page).to have_content('Linkedin não pode ficar em branco')
    expect(page).to have_content('Git não pode ficar em branco')
    expect(page).to have_content('Proficiência em Inglês não'\
                                 'pode ficar em branco')
  end

  scenario 'and must be logged in' do
    visit new_candidate_profile_path

    expect(current_path).to eq new_candidate_session_path
  end
end
