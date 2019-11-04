require 'rails_helper'

feature 'Employee edit company profile' do
  scenario 'successfully' do
    company = create(:company)
    employee = create(:employee, company: company)

    login_as(employee, scope: :employee)

    visit dashboard_companies_path
    click_on 'Completar perfil da empresa'
    click_on 'Atualizar'

    visit dashboard_companies_path
    click_on 'Editar perfil'

    fill_in 'Descrição da empresa', with: 'Empresa legal de trabalhar!'
    fill_in 'Benefícios', with: 'Vale refeição, vale transporte'
    fill_in 'Número de funcionários', with: '100'

    click_on 'Atualizar'

    expect(page).to have_content 'Empresa legal de trabalhar!'
    expect(page).to have_content 'Vale refeição, vale transporte'
    expect(page).to have_content '100'
    expect(page).to have_content 'O perfil da empresa foi atualizado com '\
                                 'sucesso.'
  end

  scenario 'and must be member of company' do
    company = create(:company)
    other_company = create(:company, name: 'Avelo',
                                     address: 'Avenida Brigadeiro Beijinho')
    other_company_profile = create(:company_profile, company: other_company)
    employee = create(:employee, company: company)

    login_as(employee, scope: :employee)

    visit edit_company_profile_path(other_company_profile)

    expect(current_path).to eq(dashboard_companies_path)
  end
end
