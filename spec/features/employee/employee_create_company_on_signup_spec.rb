require 'rails_helper'

feature 'employee create company on signup' do
  scenario 'successfully' do
    visit root_path

    click_on 'Cadastro de funcionário'

    fill_in 'E-mail', with: 'employee@company.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'

    click_on 'Sign up'
    expect(current_path).to eq(edit_company_path(Company.last))
  end

  scenario 'and update company after' do
    company = create(:company)
    employee = create(:employee, company: company)

    login_as(employee, scope: :employee)
    visit edit_company_path(employee.company)

    fill_in 'Nome', with: 'Company'
    fill_in 'Endereço', with: 'Av. Paulista, 1234'

    click_on 'Salvar'

    expect(current_path).to eq(company_path(employee.company))
    expect(page).to have_content('Endereço: Av. Paulista, 1234')
  end

  scenario 'and validates company update' do
    company = create(:company)
    employee = create(:employee, company: company)

    login_as(employee, scope: :employee)
    visit edit_company_path(employee.company)

    fill_in 'Nome', with: ''
    fill_in 'Endereço', with: ''

    click_on 'Salvar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
  end
end
