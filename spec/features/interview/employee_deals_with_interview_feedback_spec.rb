require 'rails_helper'

feature 'employee sees interview feedback' do
  scenario 'successfully' do
    company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
    company.company_profile = create(:company_profile)
    candidate = create(:candidate, status: :published)
    employee = create(:employee, email: 'joao@revelo.com.br', company: company)
    position = create(:position, company: company)
    invite = create(:invite, candidate: candidate, position: position,
                             status: :accepted)
    selection_process = invite.create_selection_process
    create(:interview, datetime: '2019-10-26 17:00:00',
                       format: :face_to_face,
                       status: :done,
                       address: 'Av. Paulista, 2000',
                       selection_process: selection_process)

    login_as(employee, scope: :employee)
    visit selection_process_candidates_path(selection_process)
    click_on 'Ver feedbacks'

    expect(page).to have_link('Voltar')
    expect(page).to have_button('Enviar Feedback')
  end
end