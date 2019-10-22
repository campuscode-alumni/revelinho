require 'rails_helper'

feature 'Employee creates position' do
  scenario 'successfully' do
    company = create(:company, name: 'Revelo')
    employee = create(:employee, company: company)

    login_as(employee, scope: :employee)
    visit dashboard_companies_path
    click_on 'Criar posição'

    fill_in 'Título', with: 'Desenvolvedor Ruby'
    fill_in 'Área', with: 'Desenvolvimento'
    fill_in 'Descrição', with: 'Posição que exige conhecimentos em HTTP, CSS, '\
                               'JavaScript e Ruby on Rails'
    select 'CLT', from: 'Tipo'
    fill_in 'De:', with: '2000'
    fill_in 'Até:', with: '4000'
    click_on 'Enviar'

    expect(page).to have_content('Desenvolvedor Ruby')
    expect(page).to have_content('Revelo')
    expect(page).to have_content('Desenvolvimento')
    expect(page).to have_content('Posição que exige conhecimentos '\
                                 'em HTTP, CSS, JavaScript e Ruby on Rails')
    expect(page).to have_content('Salário de: 2000')
    expect(page).to have_content('até: 4000')
  end

  scenario 'and must be logged in' do
    visit dashboard_companies_path

    expect(page).not_to have_link('Criar posição')
  end

  scenario 'and must fill all fields' do
    company = create(:company, name: 'Revelo')
    employee = create(:employee, company: company)

    login_as(employee, scope: :employee)
    visit dashboard_companies_path
    click_on 'Criar posição'

    fill_in 'Título', with: ''
    fill_in 'Área', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'De:', with: ''
    fill_in 'Até:', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content('Área não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Salário de não pode ficar em branco')
    expect(page).to have_content('Salário até não pode ficar em branco')
    expect(page).to have_content('Título não pode ficar em branco')
  end
end
