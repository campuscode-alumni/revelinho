require 'rails_helper'

feature 'Candidates list' do
  scenario 'Employee sees candidates list' do
    joao = create(:candidate, name: 'João')
    create(:candidate_profile, candidate: joao)
    henrique = create(:candidate, name: 'Henrique')
    create(:candidate_profile, candidate: henrique)
    derick = create(:candidate, name: 'Derick')
    create(:candidate_profile, candidate: derick)

    company_profile = create(:company_profile)
    company = create(:company, company_profile: company_profile)
    employee = create(:employee, company: company)

    login_as employee, scope: :employee
    visit dashboard_companies_path
    click_on 'Ver candidatos'

    expect(page).to have_css('.candidate', count: 3)
    expect(page).to have_content('João')
    expect(page).to have_content('Henrique')
    expect(page).to have_content('Derick')
  end

  scenario 'Employee does not see hidden candidates' do
    candidate = create(:candidate, name: 'João')
    create(:candidate_profile, candidate: candidate)
    create(:candidate, :hidden, name: 'Henrique')

    employee = create(:employee)

    login_as employee, scope: :employee
    visit dashboard_companies_path
    click_on 'Ver candidatos'

    expect(page).to have_css('.candidate', count: 1)
    expect(page).to have_content('João')
    expect(page).to_not have_content('Henrique')
  end

  scenario 'Employee sees empty list' do
    employee = create(:employee)

    login_as employee, scope: :employee
    visit dashboard_companies_path
    click_on 'Ver candidatos'

    expect(page).to have_css('.candidate', count: 0)
    expect(page).to have_content('Não há candidatos cadastrados até agora')
  end

  scenario 'Employee sees candidates\' page' do
    candidate = create(:candidate, name: 'Gustavo',
                                   occupation: 'full stack developer',
                                   educational_level: 'Mestrado em andamento')
    create(:candidate_profile, candidate: candidate)

    employee = create(:employee)

    login_as employee, scope: :employee
    visit dashboard_companies_path
    click_on 'Ver candidatos'
    click_on 'Gustavo'

    expect(page).to have_content('Gustavo')
    expect(page).to have_content('full stack developer')
    expect(page).to have_content('Mestrado em andamento')
  end

  scenario 'Employee sees candidate\'s page and returns to all candidates' do
    candidate = create(:candidate, name: 'Gustavo',
                                   occupation: 'full stack developer',
                                   educational_level: 'Mestrado em andamento')
    create(:candidate_profile, candidate: candidate)

    employee = create(:employee)

    login_as employee, scope: :employee
    visit dashboard_companies_path
    click_on 'Ver candidatos'
    click_on 'Gustavo'
    click_on I18n.t('messages.go_back')

    expect(current_path).to eq(candidates_path)
  end

  scenario 'Candidate cannot see index showing profiles of other candidates' do
    candidate = create(:candidate)
    create(:candidate_profile, candidate: candidate)
    login_as candidate, scope: :candidate

    visit candidates_path

    expect(current_path).to eq(dashboard_candidates_path)
  end
end
