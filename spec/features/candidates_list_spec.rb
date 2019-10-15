require 'rails_helper'

feature 'Candidates list' do
  scenario 'Employee sees candidates list' do
    create(:candidate, name: 'João')
    create(:candidate, name: 'Henrique')
    create(:candidate, name: 'Derick')

    employee = create(:employee)

    login_as employee, scope: :employee
    visit root_path

    expect(page).to have_css('.candidate', count: 3)
    expect(page).to have_content('João')
    expect(page).to have_content('Henrique')
    expect(page).to have_content('Derick')
  end

  scenario 'Employee does not see hidden candidates' do
    create(:candidate, name: 'João')
    create(:candidate, :hidden, name: 'Henrique')

    employee = create(:employee)

    login_as employee, scope: :employee
    visit root_path

    expect(page).to have_css('.candidate', count: 1)
    expect(page).to have_content('João')
    expect(page).to_not have_content('Henrique')
  end

  scenario 'Employee sees empty list' do
    employee = create(:employee)

    login_as employee, scope: :employee
    visit root_path

    expect(page).to have_css('.candidate', count: 0)
    expect(page).to have_content('Não há candidatos cadastrados até agora')
  end

  scenario 'Employee sees candidates\' page' do
    create(:candidate, name: 'Gustavo', occupation: 'full stack developer',
                       educational_level: 'Mestrado em andamento')

    employee = create(:employee)

    login_as employee, scope: :employee
    visit root_path
    click_on 'Gustavo'

    expect(page).to have_content('Gustavo')
    expect(page).to have_content('full stack developer')
    expect(page).to have_content('Mestrado em andamento')
  end

  scenario 'Employee sees candidate\'s page and returns to home page' do
    create(:candidate, name: 'Gustavo', occupation: 'full stack developer',
                       educational_level: 'Mestrado em andamento')

    employee = create(:employee)

    login_as employee, scope: :employee
    visit root_path
    click_on 'Gustavo'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end
end
