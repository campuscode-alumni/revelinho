require 'rails_helper'

feature 'Candidate completes personal profile' do
  scenario 'successfully' do
    candidate = create(:candidate)
    login_as(candidate, scope: :candidate)

    visit root_path
    click_on 'Concluir perfil'

    fill_in 'Experiência profissional', with: 'Revelo'
    fill_in 'Formação', with: 'Faculdade X'
    fill_in 'Habilidades', with: 'Ruby on Rails'
    fill_in 'Línguas', with: 'Inglês'
    click_on 'Atualizar'

    expect(page).to have_content('Revelo')
    expect(page).to have_content('Faculdade X')
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Inglês')
    candidate.reload
    expect(candidate).to be_published
  end
end
