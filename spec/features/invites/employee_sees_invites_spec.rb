require 'rails_helper'

feature 'Invites from dashboard page' do
  scenario 'Employee sees invites count' do
    company = create(:company, url_domain: 'revelo.com.br')
    employee = create(:employee, email: 'renata@revelo.com.br',
                                 company: company)
    candidate1 = create(:candidate)
    candidate2 = create(:candidate)
    candidate3 = create(:candidate)
    create(:candidate_profile, candidate: candidate1)
    create(:candidate_profile, candidate: candidate2)
    create(:candidate_profile, candidate: candidate3)
    position = create(:position, title: 'Engenheiro de Software Pleno',
                                 company: company)
    create(:invite, position: position,
                    candidate: candidate1)
    create(:invite, status: :rejected, position: position,
                    candidate: candidate2)
    create(:invite, status: :accepted, position: position,
                               candidate: candidate3)

    login_as(employee, scope: :employee)
    visit root_path

    within '#invites-card' do
      expect(page).to have_content(3)
    end
  end

  scenario 'Employee opens invites page' do
    company = create(:company, url_domain: 'revelo.com.br')
    employee = create(:employee, email: 'renata@revelo.com.br',
                                 company: company)
    candidate = create(:candidate, name: 'Gustavo')
    create(:candidate_profile, candidate: candidate)
    position = create(:position, company: company)
    create(:invite, :pending, position: position, candidate: candidate)

    login_as(employee, scope: :employee)
    visit root_path
    click_on 'invites-card'

    expect(page).not_to have_content('Ainda não há convites')
    within '.invite-card' do
      expect(page).to have_content('Gustavo')
      expect(page).to have_content(position.title)
    end
  end
end
