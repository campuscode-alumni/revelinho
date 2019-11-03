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
end
