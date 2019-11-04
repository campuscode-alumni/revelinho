require 'rails_helper'

feature 'Employee receive candidate feedback' do
  scenario 'pending' do
    company = create(:company)
    employee = create(:employee, company: company)
    candidate = create(:candidate, status: :published)
    position = create(:position, company: company)
    invite = create(:invite, candidate: candidate,
                             position: position,
                             status: :pending)

    login_as(employee, scope: :employee)

    visit dashboard_companies_path
    click_on 'Convites'

    expect(page).to have_content invite.position.title
    expect(page).to have_content candidate.name
    expect(page).to have_content 'R$ 4.500,00'
    expect(page).to have_content 'R$ 5.500,00'
    expect(page).to have_content 'CLT'
    expect(page).to have_content 'Esse convite está pendente'
  end

  scenario 'accepted' do
    company = create(:company)
    employee = create(:employee, company: company)
    candidate = create(:candidate, status: :published)
    position = create(:position, company: company)
    invite = create(:invite, candidate: candidate,
                             position: position,
                             status: :accepted)

    login_as(employee, scope: :employee)

    visit dashboard_companies_path
    click_on 'Convites'

    expect(page).to have_content invite.position.title
    expect(page).to have_content candidate.name
    expect(page).to have_content 'R$ 4.500,00'
    expect(page).to have_content 'R$ 5.500,00'
    expect(page).to have_content 'CLT'
    expect(page).to have_content 'Esse convite foi aceito'
  end

  scenario 'rejected' do
    company = create(:company)
    employee = create(:employee, company: company)
    candidate = create(:candidate, status: :published)
    position = create(:position, company: company)
    invite = create(:invite, candidate: candidate,
                             position: position,
                             status: :rejected)

    login_as(employee, scope: :employee)

    visit dashboard_companies_path
    click_on 'Convites'

    expect(page).to have_content invite.position.title
    expect(page).to have_content candidate.name
    expect(page).to have_content 'R$ 4.500,00'
    expect(page).to have_content 'R$ 5.500,00'
    expect(page).to have_content 'CLT'
    expect(page).to have_content 'Esse convite foi rejeitado'
  end
end
