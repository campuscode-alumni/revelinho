require 'rails_helper'

feature 'employee create company on signup' do
  scenario 'successfully' do
    visit root_path

    click_on 'Fazer cadastro'

    fill_in 'Email', with: 'employee@company.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'

    click_on 'Sign up'
    expect(current_path).to eq(edit_company_path(Company.last))
  end
end
