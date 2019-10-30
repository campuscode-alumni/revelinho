require 'rails_helper'

feature 'candidate see offer' do
  scenario 'on selection process' do
    candidate = create(:candidate)
    create(:candidate_profile, candidate: candidate)
    invite = create(:invite, candidate: candidate, status: :accepted)
    selection_process = create(:selection_process, invite: invite)
    create(:company_profile, company: selection_process.company)
    message = create(:message, selection_process: selection_process,
                               sendable: selection_process.employee,
                               text: 'Venha fazer parte da nossa equipe!')
    create(:offer, selection_process: selection_process, message: message,
                   employee: selection_process.employee, status: :pending,
                   start_date: '30-10-2019')

    login_as(selection_process.candidate, scope: :candidate)

    visit root_path
    click_on 'Convites'
    click_on 'Ver convite'

    expect(page).to have_content('PROPOSTA RECEBIDA! \o/')
    expect(page).to have_content('Parabéns! Você recebeu uma proposta. Agora'\
                                 ' avalie e veja se atende as suas'\
                                 ' expectativas')
    expect(page).to have_content('Regime de contratação: CLT')
    expect(page).to have_content('Salário: R$ 3.500,00')
    expect(page).to have_content('Data de início: 30/10/2019')

    expect(page).to have_link('Aceitar')
    expect(page).to have_link('Rejeitar')

    expect(page).not_to have_link('Quero contrata-lo')
  end

  scenario 'and accept offer' do
    candidate = create(:candidate)
    create(:candidate_profile, candidate: candidate)
    invite = create(:invite, candidate: candidate, status: :accepted)
    selection_process = create(:selection_process, invite: invite)
    create(:company_profile, company: selection_process.company)
    message = create(:message, selection_process: selection_process,
                               sendable: selection_process.employee,
                               text: 'Venha fazer parte da nossa equipe!')
    offer = create(:offer, selection_process: selection_process,
                           message: message, status: :pending,
                           employee: selection_process.employee)

    login_as(candidate, scope: :candidate)

    visit selection_process_candidates_path(selection_process)
    click_on 'Aceitar Oferta'

    expect(page).to have_content('Oferta aceita!')
    expect(offer.status).to be_accepted
  end

  scenario 'and reject offer' do
  end
end
