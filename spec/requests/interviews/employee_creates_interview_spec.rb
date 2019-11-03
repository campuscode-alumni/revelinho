require 'rails_helper'

describe 'Interviews' do
  context 'Index' do
    it 'Employee sees his companie\'s interviews' do
      company = create(:company)
      employee = create(:employee, company: company)
      candidate = create(:candidate)
      create(:candidate_profile, candidate: candidate)
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :accepted)
      selection_process = create(:selection_process, invite: invite)
      interview1 = create(:interview, selection_process: selection_process,
                                      date: '2019-11-05')
      interview2 = create(:interview, selection_process: selection_process,
                                      date: '2019-11-12')

      login_as(employee, scope: :employee)
      get selection_process_interviews_path(selection_process)

      json_interviews = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json_interviews[0][:id]).to eq interview1.id
      expect(json_interviews[0][:date]).to eq '2019-11-05'
      expect(json_interviews[1][:id]).to eq interview2.id
      expect(json_interviews[1][:date]).to eq '2019-11-12'
      expect(response.content_type).to include 'application/json'
    end

    it 'Employee sees only his companie\'s interviews' do
      company = create(:company)
      employee = create(:employee, company: company)
      candidate = create(:candidate)
      create(:candidate_profile, candidate: candidate)
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :accepted)
      selection_process = create(:selection_process, invite: invite)
      create(:interview, selection_process: selection_process,
                         date: '2019-11-05')
      interview_someone_else = create(:interview,
                                      date: '2019-11-12')

      login_as(employee, scope: :employee)
      get selection_process_interviews_path(selection_process)

      json_interviews = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json_interviews.count).to eq 1
      expect(json_interviews[0]).not_to include interview_someone_else.id
      expect(json_interviews[0]).not_to include '2019-11-12'
    end
  end

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
        interview: {
          address: 'Rua 7',
          format: :face_to_face,
          date: Time.current,
          time_from: '14:00',
          time_to: '15:00'
        }
      }
      expect(response).to have_http_status(:forbidden)
      expect(Interview.count).to eq 0
    end
  end
end
