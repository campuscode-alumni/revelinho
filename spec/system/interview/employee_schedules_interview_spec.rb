require 'rails_helper'

feature 'Employee schedules interview' do
  scenario 'successfully', :js do
    company = create(:company, url_domain: 'revelo.com.br')
    create(:company_profile, company: company)
    employee = create(:employee, email: 'renata@revelo.com.br',
                                 company: company)
    candidate = create(:candidate, name: 'Gustavo')
    create(:candidate_profile, candidate: candidate)
    position = create(:position, title: 'Engenheiro de Software Pleno',
                                 company: company)
    invite = create(:invite, position: position, candidate: candidate,
                             status: :accepted)
    selection_process = create(:selection_process, invite: invite)
    interview = build(:interview, date: DateTime.parse('25/11/2019'))

    login_as(employee, scope: :employee)
    visit selection_process_path(selection_process)

    click_on 'Agendar entrevista'
    click_on 'interview-modal-button'    
    
    
    find(:css, '#date-field > div > input').set('25/11/2019')
    
    within '#time-from-field' do
 
      find('input').fill_in with: "10:00"

    end
    within '#time-to-field' do
      find('input').fill_in with: "11:00"
    end
    fill_in 'address-field', with: interview.address

    find('label', text: 'Online').click

    click_on 'OK'

    expect(page).to have_content('Sucesso')
    expect(Interview.count).to eq(1)
  end

  scenario 'validates empty field', :js do
    company = create(:company, url_domain: 'revelo.com.br')
    create(:company_profile, company: company)
    employee = create(:employee, email: 'renata@revelo.com.br',
                                 company: company)
    candidate = create(:candidate, name: 'Gustavo')
    create(:candidate_profile, candidate: candidate)
    position = create(:position, title: 'Engenheiro de Software Pleno',
                                 company: company)
    invite = create(:invite, position: position, candidate: candidate,
                             status: :accepted)
    selection_process = create(:selection_process, invite: invite)

    login_as(employee, scope: :employee)
    visit selection_process_path(selection_process)

    click_on 'Agendar entrevista'
    click_on 'interview-modal-button'

    fill_in 'address-field', with: ''

    click_on 'OK'

    expect(page).to have_content('Erro ao salvar entrevista')
    expect(Interview.count).to eq(0)
  end

  scenario 'must be logged in' do
    company = create(:company, url_domain: 'revelo.com.br')
    create(:employee, email: 'renata@revelo.com.br',
                      company: company)
    candidate = create(:candidate, name: 'Gustavo')
    create(:candidate_profile, candidate: candidate)
    position = create(:position, title: 'Engenheiro de Software Pleno',
                                 company: company)
    create(:invite, position: position, candidate: candidate, status: :accepted)
    selection_process = create(:selection_process)

    visit new_selection_process_interview_path(selection_process)

    expect(current_path).to eq(new_employee_session_path)
  end
end
