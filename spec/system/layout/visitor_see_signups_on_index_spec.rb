require 'rails_helper'

feature 'Visitor see signups links' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_content('Cadastro de funcionário')
    expect(page).to have_content('Cadastro de candidato')
  end

  scenario 'only when not logged' do
    company = create(:company)
    employee = create(:employee, company: company)

    login_as(employee, scope: :employee)
    visit root_path

    expect(page).not_to have_css('a', text: 'Cadastro de funcionário')
    expect(page).not_to have_css('a', text: 'Cadastro de candidato')
  end
end
