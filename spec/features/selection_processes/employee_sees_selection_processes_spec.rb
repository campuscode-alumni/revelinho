require 'rails_helper'

feature 'Selection processes' do
  scenario 'Employee sees active selection processes count in dashboard page' do
    company = create(:company, url_domain: 'revelo.com.br')
    employee = create(:employee, email: 'renata@revelo.com.br',
                                 company: company)
    candidate1 = create(:candidate)
    candidate2 = create(:candidate)
    create(:candidate_profile, candidate: candidate1)
    create(:candidate_profile, candidate: candidate2)
    position = create(:position, title: 'Engenheiro de Software Pleno',
                                 company: company)
    invite1 = create(:invite, :accepted, position: position,
                                         candidate: candidate1)
    invite2 = create(:invite, :accepted, position: position,
                                         candidate: candidate2)
    create(:selection_process, invite: invite1)
    create(:selection_process, invite: invite2)

    login_as(employee, scope: :employee)
    visit root_path

    within '#selection-processes-card' do
      expect(page).to have_content(2)
    end
  end

  scenario 'Employee opens selection processes page from dashboard page' do
    company = create(:company, url_domain: 'revelo.com.br')
    employee = create(:employee, email: 'renata@revelo.com.br',
                                 company: company)
    candidate = create(:candidate, name: 'Gustavo')
    create(:candidate_profile, candidate: candidate)
    position = create(:position, title: 'Engenheiro de Software Pleno',
                                 company: company)
    invite = create(:invite, :accepted, position: position,
                                        candidate: candidate)
    create(:selection_process, invite: invite)

    login_as(employee, scope: :employee)
    visit root_path
    click_on 'selection-processes-card'
  end
end
