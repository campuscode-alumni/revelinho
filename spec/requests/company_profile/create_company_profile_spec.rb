require 'rails_helper'

describe 'Employee create company profile' do
  context 'Create' do
    it 'successfully' do
      employee = create(:employee)

      login_as(employee, scope: :employee)

      post company_profiles_path, params: { company_profile: attributes_for(
        :company_profile, company: employee.company
      ) }

      expect(response).to redirect_to(company_path(employee.company))
    end

    it 'must belong to company' do
      post company_profiles_path, params: {}
      expect(response).to redirect_to(new_employee_session_path)
    end
  end
end
