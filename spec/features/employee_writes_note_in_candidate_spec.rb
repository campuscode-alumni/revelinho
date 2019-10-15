require 'rails_helper'

feature 'Employee comments candidate' do
  scenario 'Employee writes comment' do
    candidate = create(:candidate)
    gustavo = create(:employee, email: 'gustavo@empresa.com')

    login_as gustavo, scope: :employee
    visit candidate_path(candidate)
    fill_in 'Novo comentário', with: 'Precisamos contratar essa pessoa agora!'

    expect(page).to have_css('.comment', count: 1)
    within '#comment-1' do
      expect(page).to have_content('gustavo@empresa.com')
      expect(page).to have_content('Precisamos contratar essa pessoa agora!')
    end
  end

  scenario 'Employee sees comments' do
    candidate = create(:candidate)
    gustavo = create(:employee, email: 'gustavo@empresa.com')
    fernanda = create(:employee, email: 'fernanda@empresa.com')
    create(:candidate_note, comment: 'Precisamos ' \
    'contratar essa pessoa agora!', employee: gustavo, candidate: candidate)
    create(:candidate_note, comment: 'Eu acho melhor ' \
    'continuarmos buscando...', employee: fernanda, candidate: candidate)

    login_as gustavo, scope: :employee
    visit candidate_path(candidate)

    expect(page).to have_css('.comment', count: 2)
    within '#comment-1' do
      expect(page).to have_content('gustavo@empresa.com')
      expect(page).to have_content('Precisamos contratar essa pessoa agora!')
    end
    within '#comment-2' do
      expect(page).to have_content('fernanda@empresa.com')
      expect(page).to have_content('Eu acho melhor continuarmos buscando...')
    end
  end

  xscenario 'Employee only sees comments from his companie\'s employees' do
  end
end
