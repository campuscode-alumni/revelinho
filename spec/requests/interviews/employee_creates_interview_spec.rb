require 'rails_helper'

describe 'Interviews' do
  context 'Create' do
    it 'Employee can\'t schedule interview for someone without an invitation' do
      company = create(:company, url_domain: 'revelo.com.br')
      another_company = create(:company, url_domain: 'revelo.com.br')
      employee = create(:employee, email: 'renata@revelo.com.br',
                                   company: company)
      candidate = create(:candidate, name: 'Gustavo')
      create(:candidate_profile, candidate: candidate)
      position = create(:position, title: 'Engenheiro de Software Pleno',
                                   company: another_company)
      create(:invite, position: position, candidate: candidate,
                      status: :accepted)
      selection_process = create(:selection_process)

      login_as(employee, scope: :employee)
      post selection_process_interviews_path(selection_process), params: {
        address: 'Rua 7',
        format: :face_to_face,
        date: Time.current,
        time_from: '14:00',
        time_to: '15:00'
      }
      expect(response).to have_http_status(:forbidden)
      expect(Interview.count).to eq 0
    end
  end
end
