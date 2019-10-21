require 'rails_helper'

feature 'Employee signup app' do
  scenario 'successfully' do
    visit root_path

    click_on 'Cadastro de funcionário'

    fill_in 'Email', with: 'employee@company.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'

    click_on 'Sign up'

    employee = Employee.last

    expect(current_path).to eq(edit_company_path(employee.company))
  end

  scenario 'and fill in validates' do
    visit root_path

    click_on 'Cadastro de funcionário'

    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    fill_in 'Password confirmation', with: ''

    click_on 'Sign up'

    expect(page).to have_content('Não foi possível salvar o employee: 2 erros.')
  end

  scenario 'and logout' do
    employee = create(:employee, email: 'employee@company.com')

    login_as(employee, scope: :employee)
    visit root_path

    click_on 'Logout'

    expect(page).to have_link('Cadastro de funcionário')
    expect(page).not_to have_link('Logout')
  end

  scenario 'and see your company dashboard' do
    company = create(:company, name: 'Revelo', address: 'Av. Paulista',
                               url_domain: 'revelo.com.br')

    visit root_path

    click_on 'Cadastro de funcionário'

    fill_in 'Email', with: 'joao.silva@revelo.com.br'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'

    click_on 'Sign up'

    expect(Company.count).to eq 1
    expect(current_path).to eq(dashboard_companies_path)
    expect(page).to have_content('Revelo')
  end
end
