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
    create(:interview, date: '2019-10-26',
                       time_from: '17:00',
                       time_to: '18:00',
                       format: :face_to_face,
                       status: :done,
                       address: 'Av. Paulista, 2000',
                       selection_process: selection_process)

    login_as(employee, scope: :employee)
    visit selection_process_candidates_path(selection_process)
    click_on 'Feedbacks'

    expect(page).to have_link('Voltar')
    expect(page).to have_button('Enviar Feedback')
  end

  scenario 'and successfully sends a message' do
    company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
    company.company_profile = create(:company_profile)
    candidate = create(:candidate, status: :published)
    employee = create(:employee, email: 'joao@revelo.com.br', company: company)
    position = create(:position, company: company)
    invite = create(:invite, candidate: candidate, position: position,
                             status: :accepted)
    selection_process = invite.create_selection_process
    create(:interview, date: '2019-10-26',
                       time_from: '17:00',
                       time_to: '18:00',
                       format: :face_to_face,
                       status: :done,
                       address: 'Av. Paulista, 2000',
                       selection_process: selection_process)

    login_as(employee, scope: :employee)
    visit selection_process_candidates_path(invite.selection_process)
    click_on 'Feedbacks'

    fill_in 'Escreva a sua mensagem', with: 'A entrevista foi um sucesso'
    click_on('Enviar Feedback')

    expect(page).to have_content(employee.name)
    expect(page).to have_content('A entrevista foi um sucesso')
  end

  scenario 'and fails to send empty field' do
    company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
    company.company_profile = create(:company_profile)
    candidate = create(:candidate, status: :published)
    employee = create(:employee, email: 'joao@revelo.com.br', company: company)
    position = create(:position, company: company)
    invite = create(:invite, candidate: candidate, position: position,
                             status: :accepted)
    selection_process = invite.create_selection_process
    create(:interview, date: '2019-10-26',
                       time_from: '17:00',
                       time_to: '18:00',
                       format: :face_to_face,
                       status: :done,
                       address: 'Av. Paulista, 2000',
                       selection_process: selection_process)

    login_as(employee, scope: :employee)
    visit selection_process_candidates_path(invite.selection_process)
    click_on 'Feedbacks'

    fill_in 'Escreva a sua mensagem', with: ''
    click_on('Enviar Feedback')

    expect(page).not_to have_content(employee.name)
    expect(page).to have_content('Não foi possivel enviar feedback.'\
                                 ' Tente novamente')
  end

  scenario 'and can see feedbacks left from other employees' do
    company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
    company.company_profile = create(:company_profile)
    candidate = create(:candidate, status: :published)
    employee = create(:employee, email: 'joao@revelo.com.br', company: company)
    another_employee = create(:employee, email: 'pedro@revelo.com.br',
                                         company: company)
    position = create(:position, company: company)
    invite = create(:invite, candidate: candidate, position: position,
                             status: :accepted)
    selection_process = invite.create_selection_process
    interview = create(:interview, date: '2019-10-26',
                                   time_from: '17:00',
                                   time_to: '18:00',
                                   format: :face_to_face,
                                   status: :done,
                                   address: 'Av. Paulista, 2000',
                                   selection_process: selection_process)

    interview.interview_feedbacks << create(:interview_feedback,
                                            employee: employee,
                                            interview: interview)

    login_as(another_employee, scope: :employee)
    visit selection_process_candidates_path(invite.selection_process)
    click_on 'Feedbacks'

    expect(page).to have_content(employee.name)
    expect(page).to have_content('Foi uma boa entrevista')
  end

  scenario 'and only sees their message on the right interview feedback page' do
    company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
    company.company_profile = create(:company_profile)
    candidate = create(:candidate, status: :published)
    employee = create(:employee, email: 'joao@revelo.com.br', company: company)
    position = create(:position, company: company)
    invite = create(:invite, candidate: candidate, position: position,
                             status: :accepted)
    selection_process = invite.create_selection_process
    interview = create(:interview, date: '2019-10-26',
                                   time_from: '17:00',
                                   time_to: '18:00',
                                   format: :face_to_face,
                                   status: :done,
                                   address: 'Av. Paulista, 2000',
                                   selection_process: selection_process)
    another_interview = create(:interview, date: '2019-10-26',
                                           time_from: '17:00',
                                           time_to: '18:00',
                                           format: :face_to_face,
                                           status: :done,
                                           address: 'Av. Paulista, 2000',
                                           selection_process: selection_process)

    interview.interview_feedbacks << create(:interview_feedback,
                                            employee: employee,
                                            interview: interview)

    login_as(employee, scope: :employee)
    visit selection_process_candidates_path(invite.selection_process)

    within "#interview-#{another_interview.id}" do
      click_on 'Feedbacks'
    end

    expect(page).not_to have_content(employee.name)
    expect(page).not_to have_content('A entrevista foi um sucesso')
  end
end
