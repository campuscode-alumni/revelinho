require 'rails_helper'

feature 'Employee sends interview feedback' do
  scenario 'successfully' do
    company = create(:company)
    candidate = create(:candidate)
    employee = create(:employee, company: company)
    position = create(:position, company: company)
    invite = create(:invite, candidate: candidate, position: position,
                             status: :pending)
    invite.create_selection_process

    login_as employee, scope: :employee

    visit selection_process_candidates_path(invite.selection_process)

    expect(page).to have_content('Enviar feedback')
  end
end
