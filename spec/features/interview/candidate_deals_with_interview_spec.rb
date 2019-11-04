require 'rails_helper'

feature 'candidate sees interview invite' do
  scenario 'successfully' do
    company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
    company.company_profile = create(:company_profile)
    candidate = create(:candidate, status: :published)
    create(:employee, email: 'joao@revelo.com.br', company: company)
    position = create(:position, company: company)
    invite = create(:invite, candidate: candidate, position: position,
                             status: :accepted)
    selection_process = invite.create_selection_process
    create(:interview, date: '2019-10-26',
                       time_from: '17:00',
                       time_to: '18:00',
                       format: :face_to_face,
                       status: :pending,
                       address: 'Av. Paulista, 2000',
                       selection_process: selection_process)

    login_as(candidate, scope: :candidate)
    visit selection_process_candidates_path(selection_process)

    expect(page).to have_content('Entrevistas')
    expect(page).to have_content('26 de outubro de 2019, das 17:00 às 18:00')
    expect(page).to have_content('Endereço: Av. Paulista, 2000')
    expect(page).to have_content('Formato: Presencial')
    expect(page).to have_content('Aguardando resposta')
    expect(page).to have_link('Aceitar')
    expect(page).to have_link('Recusar')
  end

  scenario 'and accepts it' do
    company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
    company.company_profile = create(:company_profile)
    candidate = create(:candidate, status: :published)
    create(:employee, email: 'joao@revelo.com.br', company: company)
    position = create(:position, company: company)
    invite = create(:invite, candidate: candidate, position: position,
                             status: :accepted)
    selection_process = invite.create_selection_process
    interview = create(:interview, date: '2019-10-26',
                                   time_from: '17:00',
                                   time_to: '18:00',
                                   status: :pending,
                                   format: :face_to_face,
                                   address: 'Av. Paulista, 2000',
                                   selection_process: selection_process)
    mailer_spy = class_spy('InterviewMailer')
    stub_const('InterviewMailer', mailer_spy)
    mail = double('mail', deliver_now: nil)
    allow(mailer_spy).to receive(:interview_accepted).and_return(mail)

    login_as(candidate, scope: :candidate)
    visit selection_process_candidates_path(selection_process)
    click_on 'Aceitar'

    interview.reload

    expect(page).to have_content('Entrevista agendada')
    expect(page).not_to have_link('Aceitar')
    expect(page).not_to have_link('Recusar')
    expect(interview).to be_scheduled
    expect(mailer_spy).to have_received(:interview_accepted).with(interview.id)
  end

  scenario 'and rejects it' do
    company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
    company.company_profile = create(:company_profile)
    candidate = create(:candidate, status: :published)
    create(:employee, email: 'joao@revelo.com.br', company: company)
    position = create(:position, company: company)
    invite = create(:invite, candidate: candidate, position: position,
                             status: :accepted)
    selection_process = invite.create_selection_process
    interview = create(:interview, date: '2019-10-26',
                                   time_from: '17:00',
                                   time_to: '18:00',
                                   status: :pending,
                                   format: :face_to_face,
                                   address: 'Av. Paulista, 2000',
                                   selection_process: selection_process)

    login_as(candidate, scope: :candidate)
    visit selection_process_candidates_path(selection_process)
    click_on 'Recusar'

    interview.reload

    expect(page).to have_content('Entrevista cancelada')
    expect(page).not_to have_link('Aceitar')
    expect(page).not_to have_link('Recusar')
    expect(interview).to be_canceled
  end

  scenario 'and cannot see the status button' do
    company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
    company.company_profile = create(:company_profile)
    candidate = create(:candidate, status: :published)
    create(:employee, email: 'joao@revelo.com.br', company: company)
    position = create(:position, company: company)
    invite = create(:invite, candidate: candidate, position: position,
                             status: :accepted)
    selection_process = invite.create_selection_process
    interview = create(:interview, date: '2019-10-26',
                                   time_from: '17:00',
                                   time_to: '18:00',
                                   format: :face_to_face,
                                   status: :pending,
                                   address: 'Av. Paulista, 2000',
                                   selection_process: selection_process)

    login_as(candidate, scope: :candidate)
    visit selection_process_candidates_path(selection_process)

    expect(page).to have_content(interview.address)
    expect(page).not_to have_link('Marcar como')
  end

  scenario 'and cannot see the feedback button' do
    company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
    company.company_profile = create(:company_profile)
    candidate = create(:candidate, status: :published)
    create(:employee, email: 'joao@revelo.com.br', company: company)
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

    login_as(candidate, scope: :candidate)
    visit selection_process_candidates_path(selection_process)

    expect(page).to have_content(interview.address)
    expect(page).not_to have_link('Marcar como')
    expect(page).not_to have_link('Feedbacks')
  end
end
