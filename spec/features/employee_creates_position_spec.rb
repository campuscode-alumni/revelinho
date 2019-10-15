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
    select 'CLT', from: 'Tipo'
    fill_in 'Salário', with: '2000'
    click_on 'Enviar'

    expect(page).to have_content('Desenvolvedor Ruby')
    expect(page).to have_content('Revelo')
    expect(page).to have_content('Desenvolvimento')
    expect(page).to have_content('Vaga que exige conhecimentos em HTTP, CSS, JavaScript e Ruby on Rails')
    expect(page).to have_content('R$ 2000')
  end

  scenario 'and must be logged in' do
    visit root_path

    expect(page).not_to have_link('Criar vaga')
  end

  scenario 'and must fill all fields' do
    company = create(:company, name: 'Revelo')
    employee = create(:employee, company: company)

    login_as(employee, scope: :employee)
    visit root_path
    click_on 'Criar vaga'

    fill_in 'Título', with: ''
    fill_in 'Área', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Salário', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content('Área não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Salário não pode ficar em branco')
    expect(page).to have_content('Título não pode ficar em branco')
  end
end
