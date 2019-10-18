require 'rails_helper'

describe 'Visitor cannot create company profile' do
  context 'create' do
    it 'post to company profiles path' do
      company_profile = build(:company_profile)
      post company_profiles_path, params: { company_profile: {
        full_description: company_profile.full_description,
        benefits: company_profile.benefits,
        logo: company_profile.logo
      } }
      expect(response).to redirect_to(new_employee_session_path)
      expect(response).to have_http_status(:found)
    end
  end
end
