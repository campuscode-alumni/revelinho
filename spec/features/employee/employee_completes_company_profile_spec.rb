require 'rails_helper'

feature 'Employee tries to complete company profile' do
  scenario 'successfully' do
    company = create(:company, status: :active)
    employee = create(:employee, company: company)

    company_profile = build(:company_profile)

    login_as(employee, scope: :employee)

    visit company_path(company)
    click_on 'Completar perfil da empresa'

    fill_in 'Descrição da empresa', with: company_profile.full_description
    fill_in 'Benefícios', with: company_profile.benefits
    attach_file('Logo', Rails.root.join('spec',
                                        'support',
                                        'images',
                                        'gatinho.jpg'))

    click_on 'Atualizar'

    expect(employee.company.reload).to be_active
    expect(page).to have_css('img[src*="gatinho.jpg"]')
    expect(page).to have_content company_profile.benefits
    expect(page).to have_content company_profile.full_description
    expect(page).to have_content 'O perfil da empresa foi atualizado com '\
                                 'sucesso.'
    expect(page).to have_link('Editar perfil')
  end

  scenario 'unsuccessfully' do
    company = create(:company, status: :active)
    employee = create(:employee, company: company)

    login_as(employee, scope: :employee)

    visit company_path(company)
    click_on 'Completar perfil da empresa'

    fill_in 'Descrição da empresa', with: ''
    fill_in 'Benefícios', with: ''

    click_on 'Atualizar'

    expect(page).to have_content 'O perfil da empresa foi atualizado com '\
                                 'sucesso.'
    expect(page).to have_link('Editar perfil')
  end

  scenario 'and fails because it is not logged in' do
    visit new_company_profile_path

    expect(current_path).to eq new_employee_session_path
  end
end
