require 'rails_helper'

feature 'candidate sees pending invites' do
  scenario 'successfully' do
    position = create(:position, :with_company)
    candidate = create(:candidate, status: :published)
    create(:candidate_profile, candidate: candidate)
    invite = create(:invite, candidate: candidate,
                             position: position,
                             status: :pending)

    login_as(candidate, scope: :candidate)

    visit root_path
    click_on 'Convites'

    expect(page).to have_content 'Rejeitar'
    expect(page).to have_content 'Aceitar'
    expect(page).to have_content invite.position.title
    expect(page).to have_content invite.position.salary
    expect(page).to have_content invite.position.industry
    expect(page).to have_content invite.position.description
    expect(page).to have_content invite.position.position_type
  end

  scenario 'and accept invite successfully' do
    candidate = create(:candidate, status: :published)
    position = create(:position, :with_company)
    invite = create(:invite, candidate: candidate,
                             position: position,
                             status: :pending)

    login_as(candidate, scope: :candidate)
    visit invites_candidates_path

    click_link('Aceitar convite')

    invite.reload

    expect(invite.status).to eq 'accepted'
    expect(invite.selection_process).to eq SelectionProcess.last
  end

  scenario 'and rejects invite successfully' do
    candidate = create(:candidate, status: :published)
    position = create(:position, :with_company)
    invite = create(:invite, candidate: candidate,
                             position: position,
                             status: :pending)

    login_as(candidate, scope: :candidate)
    visit invites_candidates_path

    click_on('Rejeitar')

    invite.reload

    expect(invite).to be_accepted
    expect(SelectionProcess.count).to eq 0
  end
end