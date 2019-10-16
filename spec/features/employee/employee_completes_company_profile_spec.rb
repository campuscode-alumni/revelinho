require 'rails_helper'

feature 'Employee completes company profile' do
  scenario 'successfully' do
    company = create(:company, status: :pending)
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
                                 'sucesso. Agora você pode cadastrar vagas.'
  end
end
