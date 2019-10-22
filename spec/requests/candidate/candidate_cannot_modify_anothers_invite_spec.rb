require 'rails_helper'

describe 'Candidate cannot modify anothers invite' do
  it 'accept throught post path' do
    position = create(:position)
    candidate = create(:candidate, status: :published)
    create(:candidate_profile, candidate: candidate)
    invite = create(:invite, candidate: candidate,
                             position: position,
                             status: :pending)

    unauthorized_candidate = create(:candidate, status: :published)

    login_as(unauthorized_candidate, scope: :candidate)

    post accept_invites_candidate_path(invite)

    expect(response).to redirect_to(invites_candidates_path)
  end

  it 'reject throught post path' do
    position = create(:position)
    candidate = create(:candidate, status: :published)
    create(:candidate_profile, candidate: candidate)
    invite = create(:invite, candidate: candidate,
                             position: position,
                             status: :pending)

    unauthorized_candidate = create(:candidate, status: :published)

    login_as(unauthorized_candidate, scope: :candidate)

    post reject_invites_candidate_path(invite)

    expect(response).to redirect_to(invites_candidates_path)
  end
end
