require 'rails_helper'

feature 'Employee tries to complete company profile' do
  scenario 'successfully' do
    company = create(:company)
    employee = create(:employee, company: company)

    company_profile = build(:company_profile)

    login_as(employee, scope: :employee)

    visit dashboard_companies_path
    click_on 'Completar perfil da empresa'

    fill_in 'Descrição da empresa', with: company_profile.full_description
    fill_in 'Benefícios', with: company_profile.benefits
    fill_in 'Número de funcionários', with: company_profile.employees_number
    fill_in 'Site da empresa', with: company_profile.website
    fill_in 'Telefone', with: company_profile.phone
    fill_in 'Missão', with: company_profile.mission
    fill_in 'Categoria', with: company_profile.category
    fill_in 'Atrativos', with: company_profile.attractives
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
  end

  scenario 'and inserts blank data' do
    company = create(:company)
    employee = create(:employee, company: company)

    login_as(employee, scope: :employee)

    visit dashboard_companies_path
    click_on 'Completar perfil da empresa'

    fill_in 'Descrição da empresa', with: ''
    fill_in 'Benefícios', with: ''

    click_on 'Atualizar'

    expect(page).to have_content 'O perfil da empresa foi atualizado com '\
                                 'sucesso.'
  end

  scenario 'and fails because it is not logged in' do
    visit new_company_profile_path

    expect(current_path).to eq new_employee_session_path
  end

  scenario 'and must be member of company' do
    company = create(:company)
    other_company = create(:company, status: :active, name: 'Avelo',
                                     address: 'Avenida Brigadeiro Beijinho')
    employee = create(:employee, company: company)

    login_as(employee, scope: :employee)

    visit company_path(company)

    expect(page).to have_content company.name
    expect(page).to have_content company.address
    expect(page).not_to have_content other_company.name
    expect(page).not_to have_content other_company.address
  end
end
