require 'rails_helper'

feature 'Positions list' do
  scenario 'Employee sees positions page' do
    company = create(:company, url_domain: 'revelo.com.br')
    employee = create(:employee, company: company)
    create(:position, title: 'Engenheiro de Software Pleno',
                      company: company)
    create(:position, title: 'Engenheiro de Software Sênior',
                      company: company)
    create(:position, title: 'Engenheiro de Infra',
                      company: company)

    login_as(employee, scope: :employee)
    visit(positions_path)

    expect(page).to have_content('Posições de minha empresa')
    expect(page).to have_link('Nova posição', href: new_position_path)
    expect(page).to have_css('.position', count: 3)
    expect(page).to have_content('Engenheiro de Software Pleno')
    expect(page).to have_content('Engenheiro de Software Sênior')
    expect(page).to have_content('Engenheiro de Infra')
  end

  scenario 'Employee sees position details' do
    company = create(:company, url_domain: 'revelo.com.br')
    employee = create(:employee, company: company)
    position = create(
      :position,
      title: 'Engenheiro de Software Pleno',
      company: company,
      description: 'Artista de commits',
      salary_from: 3500, salary_to: 5000,
      industry: 'Tecnologia e serviços',
      office_hours: :full_time, hiring_scheme: :clt
    )

    login_as(employee, scope: :employee)
    visit(positions_path)
    click_on('detalhes')

    within "#position-#{position.id}" do
      expect(page).to have_content('Engenheiro de Software Pleno')

      within '.details' do
        expect(page).to have_content('Artista de commits')
        expect(page).to have_content('3500')
        expect(page).to have_content('5000')
        expect(page).to have_content('Tecnologia e serviços')
      end
    end
  end

  scenario 'Employee can\'t see other company\'s positions' do
    company = create(:company, url_domain: 'revelo.com.br')
    employee = create(:employee, company: company)
    create(:position, title: 'Engenheiro de Software Pleno',
                      company: company)
    create(:position, title: 'Cargo de outra empresa')

    login_as(employee, scope: :employee)
    visit(positions_path)

    expect(page).to have_css('.position', count: 1)
    expect(page).to have_content('Engenheiro de Software Pleno')
    expect(page).not_to have_content('Cargo de outra empresa')
  end
end
