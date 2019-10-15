require 'rails_helper'

describe 'Employee is logged in to create a position' do
  context 'Create' do
    it 'post to position path' do
      post positions_path, params: { position: attributes_for(:position, company: create(:company)) }
      expect(response).to redirect_to(new_employee_session_path)
    end
  end
end
