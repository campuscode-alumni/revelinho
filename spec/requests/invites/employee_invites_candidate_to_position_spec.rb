require 'rails_helper'

describe 'Invitations' do
  context 'Create' do
    it 'Employee can\'t invite candidate to another companies\' position' do
      company_contractor = create(:company,
                                  :active,
                                  url_domain: 'revelo.com.br')
      company_other = create(:company, :active, url_domain: 'jobs.com.br')
      employee = create(:employee, email: 'renata@revelo.com.br',
                                   company: company_contractor)
      candidate = create(:candidate, name: 'Gustavo')
      create(:candidate_profile, candidate: candidate)
      position_invalid = create(:position, title: 'Engenheiro de Sistemas',
                                           company: company_other)

      login_as(employee, scope: :employee)
      post invite_candidate_path(candidate), params: {
        message: 'Venha trabalhar conosco',
        position_id: position_invalid.id
      }
      expect(response).to redirect_to(root_path)
    end
  end
end
