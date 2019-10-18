require 'rails_helper'

describe 'Candidate cannot reject anothers invite' do
  it 'throught post path' do
    position = create(:position, :with_company)
    candidate = create(:candidate, status: :published)
    create(:candidate_profile, candidate: candidate)
    invite = create(:invite, candidate: candidate,
                             position: position,
                             status: :pending)

    unauthorized_candidate = create(:candidate, status: :published)

    login_as(unauthorized_candidate, scope: :candidate)

    post reject_invites_candidate_path, params: { invite: { 
      message: invite.message,
      status: invite.status,
      candidate: invite.candidate,
      position: invite.position
      } }

    expect(response).to redirect_to(invites_candidates_path)
  end
end
