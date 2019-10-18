require 'rails_helper'

feature 'candidate sees pending invites' do
  scenario 'successfully' do
    candidate = create(:candidate, status: :published)
    invite = create(:invite, candidate: candidate, status: :pending)

    login_as(candidate, scope: :candidate)

    visit root_path
    # find('#my-pending_invites').click
    click_link('my-pending-invites')

    expect(page).to have_content 'Negar'
    expect(page).to have_content 'Aceitar'
    expect(page).to have_content invite.position.title
    expect(page).to have_content invite.position.salary
    expect(page).to have_content invite.position.industry
    expect(page).to have_content invite.position.description
    expect(page).to have_content invite.position.position_type
  end

  scenario 'and accept invite successfully' do
    candidate = create(:candidate, status: :published)
    invite = create(:invite, candidate: candidate, status: :pending)

    login_as(candidate, scope: :candidate)
    visit candidate_invite_path

    click_link('Aceitar convite')

    expect(invite.selection_process).to eq SelectionProcess.last
  end
end
