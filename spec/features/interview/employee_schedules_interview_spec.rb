require 'rails_helper'

feature 'Employee schedules interview' do
  scenario 'successfully' do
    company = create(:company, url_domain: 'revelo.com.br')
    employee = create(:employee, email: 'renata@revelo.com.br',
                                 company: company)
    candidate = create(:candidate, name: 'Gustavo')
    create(:candidate_profile, candidate: candidate)
    position = create(:position, title: 'Engenheiro de Software Pleno',
                                 company: company)
    create(:invite, position: position, candidate: candidate, status: :accepted)
    selection_process = create(:selection_process)
    interview = build(:interview, datetime: DateTime.parse('25/11/2019 10:30'))

    login_as(employee, scope: :employee)
    visit new_selection_process_interview_path(selection_process)

    fill_in 'date-field', with: '25/11/2019'
    select '10', from: 'hour-field'
    select '30', from: 'minutes-field'
    fill_in 'Endereço', with: interview.address
    select I18n.t(:"format.#{interview.format}"), from: 'Formato'
    click_on 'Agendar'

    expect(current_path).to eq(selection_process_path(selection_process))
    expect(page).to have_content('Solicitação enviada')
    expect(page).to have_content('Aguardando confirmação do candidato')
    within '.interviews' do
      expect(page).to have_content('25 de novembro de 2019')
      expect(page).to have_content('10:30')
      expect(page).to have_content(interview.address)
      expect(page).to have_content(I18n.t(:"format.#{interview.format}"))
    end
    expect(Interview.count).to eq(1)
  end
end
