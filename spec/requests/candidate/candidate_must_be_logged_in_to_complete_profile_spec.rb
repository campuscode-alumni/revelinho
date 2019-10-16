require 'rails_helper'

describe 'Candidate must be logged in to complete their profile' do
  context 'Create' do
    it 'post to candidate profiles path' do
      post candidate_profiles_path, params: { candidate_profile: attributes_for(
        :candidate_profile, candidate: create(:candidate)
      ) }
      expect(response).to redirect_to(new_candidate_session_path)
    end
  end
end
