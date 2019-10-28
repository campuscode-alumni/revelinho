require 'rails_helper'

xfeature 'Employee sees selection processes' do
  scenario 'successfully' do
    company = create(:company, :active, url_domain: 'revelo.com.br')
    employee = create(:employee, email: 'renata@revelo.com.br',
                                 company: company)
    candidate = create(:candidate, name: 'Gustavo')
    create(:candidate_profile, candidate: candidate)
    position = create(:position, title: 'Engenheiro de Software Pleno',
                                 company: company)
    create(:invite, position: position, candidate: candidate, status: :accepted)
    create(:selection_process)

    login_as(employee, scope: :employee)
    visit selection_process_path

    expect(page).to have_content('Processos seletivos:')
    expect(page).to have_css('selection-process', count: 1)
    expect(page).to have_content(candidate.name)
    expect(page).to have_content(position.name)
  end
end
