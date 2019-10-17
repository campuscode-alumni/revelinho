require 'rails_helper'

feature 'visitor has limited access' do
  scenario 'and can not see company' do
    company = create(:company)
    visit edit_company_path(company)

    expect(current_path).not_to eq edit_company_path(company)
    expect(current_path).to eq new_employee_session_path
  end
end
