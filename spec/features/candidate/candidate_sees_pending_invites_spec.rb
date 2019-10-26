require 'rails_helper'

feature 'candidate sees pending invites' do
  scenario 'successfully' do
    position = create(:position, salary_from: 4500, salary_to: 5500)
    position.company.company_profile = create(:company_profile)

    candidate = create(:candidate, status: :published)
    create(:candidate_profile, candidate: candidate)
    invite = create(:invite, candidate: candidate,
                             position: position,
                             status: :pending)

    login_as(candidate, scope: :candidate)

    visit root_path
    click_on 'Convites'

    expect(page).to have_link 'Aceitar'
    expect(page).to have_link 'Rejeitar'
    expect(page).to have_content invite.position.title
    expect(page).to have_content 'R$ 4.500,00'
    expect(page).to have_content 'R$ 5.500,00'
    expect(page).to have_content invite.position.industry
    expect(page).to have_content invite.position.description
    expect(page).to have_content 'CLT'
    expect(page).to have_content 'Olá, ser humano. '\
    'Venha fazer parte do nosso time'
  end

  scenario 'and accept invite successfully' do
    candidate = create(:candidate, status: :published)
    position = create(:position)
    position.company.company_profile = create(:company_profile)
    invite = create(:invite, candidate: candidate,
                             position: position,
                             status: :pending)

    login_as(candidate, scope: :candidate)
    visit invites_candidates_path

    click_link('Aceitar')
    visit invites_candidates_path

    invite.reload

    expect(page).to have_content('Esse convite foi aceito')
    expect(invite).to be_accepted
    expect(invite.selection_process).to eq SelectionProcess.last
  end

  scenario 'and can not access other candidate invites list' do
    candidate = create(:candidate, status: :published)
    other_candidate = create(:candidate, status: :published)
    position = create(:position, title: 'Desenvolvedor fullstack')
    create(:invite, candidate: candidate, position: position,
                    status: :pending)

    login_as(other_candidate, scope: :candidate)
    visit invites_candidates_path

    expect(page).to_not have_content('Desenvolvedor fullstack')
  end

  scenario 'and rejects invite successfully' do
    candidate = create(:candidate, status: :published)
    position = create(:position)
    position.company.company_profile = create(:company_profile)
    invite = create(:invite, candidate: candidate,
                             position: position,
                             status: :pending)

    login_as(candidate, scope: :candidate)
    visit invites_candidates_path

    click_on('Rejeitar')

    invite.reload

    expect(page).to have_content('Esse convite foi rejeitado')
    expect(invite).to be_rejected
    expect(SelectionProcess.count).to eq 0
  end
end
