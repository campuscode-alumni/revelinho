require 'rails_helper'

describe 'Interviews' do
  context 'Update' do
    it 'Employee updates one of his interviews' do
      company = create(:company)
      employee = create(:employee, company: company)
      candidate = create(:candidate)
      create(:candidate_profile, candidate: candidate)
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :accepted)
      selection_process = create(:selection_process, invite: invite)
      interview = create(:interview, selection_process: selection_process,
                                     date: '2019-11-05')

      login_as(employee, scope: :employee)
      patch selection_process_interview_path(
        id: interview.id, selection_process_id: selection_process.id
      ), params: { interview: { date: '2019-11-12' } }

      json_interview = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json_interview[:id]).to eq interview.id
      expect(json_interview[:date]).to eq '2019-11-12'
      expect(response.content_type).to include 'application/json'
    end

    it 'Employee can\'t update interview with validation errors' do
      company = create(:company)
      employee = create(:employee, company: company)
      candidate = create(:candidate)
      create(:candidate_profile, candidate: candidate)
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :accepted)
      selection_process = create(:selection_process, invite: invite)
      interview = create(:interview, selection_process: selection_process,
                                     date: '2019-11-05')

      login_as(employee, scope: :employee)
      patch selection_process_interview_path(
        id: interview.id, selection_process_id: selection_process.id
      ), params: { interview: { date: '' } }
      old_date = interview.date
      interview.reload

      expect(interview.date).to eq(old_date)
      expect(response).to have_http_status(:bad_request)
      expect(response.content_type).to include 'application/json'
    end

    it 'Employee can\'t update another company\'s interviews' do
      company = create(:company)
      employee = create(:employee, company: company)
      interview = create(:interview, date: '2019-11-01')

      login_as(employee, scope: :employee)
      patch selection_process_interview_path(
        id: interview.id, selection_process_id: interview.selection_process.id
      ), params: { interview: { date: '2019-11-02' } }
      old_date = interview.date
      interview.reload

      expect(interview.date).to eq(old_date)
      expect(response).to have_http_status(:forbidden)
      expect(response.content_type).to include 'application/json'
    end
  end
end
