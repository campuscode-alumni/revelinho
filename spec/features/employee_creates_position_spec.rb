require 'rails_helper'

feature 'Employee creates position' do
  scenario 'successfully' do
    company = create(:company, name: 'Revelo')
    employee = create(:employee, company: company)

    login_as(employee, scope: :employee)
    visit root_path
    click_on 'Criar vaga'

    fill_in 'Título', with: 'Desenvolvedor Ruby'
    fill_in 'Área', with: 'Desenvolvimento'
    fill_in 'Descrição', with: 'Vaga que exige conhecimentos em HTTP, CSS, JavaScript e Ruby on Rails'
    fill_in 'Salário', with: '2000'
    click_on 'Enviar'

    expect(page).to have_content('Desenvolvedor Ruby')
    expect(page).to have_content('Revelo')
    expect(page).to have_content('Desenvolvimento')
    expect(page).to have_content('Vaga que exige conhecimentos em HTTP, CSS, JavaScript e Ruby on Rails')
    expect(page).to have_content('R$ 2000.0')
  end
end
