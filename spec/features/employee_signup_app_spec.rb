require 'rails_helper'

feature 'Employee signup app' do
  scenario 'successfully' do
    visit root_path

    click_on 'Fazer cadastro'

    fill_in 'Email', with: 'employee@company.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'

    click_on 'Sign up'

    employee = Employee.last

    expect(current_path).to eq(edit_company_path(employee.company))
  end

  scenario 'employee logged out can not access company' do
    company = create(:company)
    visit edit_company_path(company)

    expect(current_path).not_to eq edit_company_path(company)
    expect(current_path).to eq new_employee_session_path
  end

  scenario 'and fill in validates' do
    visit root_path

    click_on 'Fazer cadastro'

    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    fill_in 'Password confirmation', with: ''

    click_on 'Sign up'

    expect(page).to have_content('2 erros encontrados impedem de realizar o cadastro')
  end

  scenario 'and logout' do
    employee = create(:employee, email: 'employee@company.com')

    login_as(employee, scope: :employee)
    visit root_path

    click_on 'Logout'

    expect(page).to have_content('Fazer cadastro')
    expect(page).not_to have_content('Logout')
  end
end
