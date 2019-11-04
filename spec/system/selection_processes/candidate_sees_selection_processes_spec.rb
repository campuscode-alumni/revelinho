require 'rails_helper'

feature 'Selection processes' do
  scenario 'Candidate sees invites count in dashboard page' do
    company = create(:company, url_domain: 'revelo.com.br')
    create(:company_profile, company: company)
    create(:employee, email: 'renata@revelo.com.br',
                      company: company)
    candidate = create(:candidate)
    create(:candidate_profile, candidate: candidate)
    position = create(:position, title: 'Engenheiro de Software Pleno',
                                 company: company)
    invite = create(:invite, :accepted, position: position,
                                        candidate: candidate)

    create(:selection_process, invite: invite)

    login_as(candidate, scope: :candidate)
    visit root_path

    within '#invites-card' do
      expect(page).to have_content(1)
    end
  end

  scenario 'Candidate sees a selection process from selection processes page' do
    company = create(:company, url_domain: 'revelo.com.br')
    create(:company_profile, company: company)
    create(:employee, email: 'renata@revelo.com.br',
                      company: company)
    candidate = create(:candidate)
    create(:candidate_profile, candidate: candidate)
    position = create(:position, title: 'Engenheiro de Software Pleno',
                                 company: company)
    invite = create(:invite, :accepted, position: position,
                                        candidate: candidate)

    create(:selection_process, invite: invite)

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Convites'
    click_on 'Ver convite'

    expect(page).not_to have_content('Agendar nova entrevista')
    expect(page).not_to have_content('Quero contratá-lo')
  end
end
