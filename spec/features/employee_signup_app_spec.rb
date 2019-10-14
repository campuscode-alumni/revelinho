require 'rails_helper'

feature 'Employee signup app' do
  scenario 'successfully' do
    visit root_path

    click_on 'Fazer cadastro'

    fill_in 'Email', with: 'employee@company.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'

    click_on 'Sign up'

    expect(page).to have_content('Usuário employee@company.com logado com sucesso.')
    expect(page).not_to have_content('Fazer cadastro')
    expect(current_path).to eq(root_path)
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
