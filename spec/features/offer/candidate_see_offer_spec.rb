require 'rails_helper'

feature 'candidate see offer' do
  scenario 'succesfully' do
    candidate = create(:candidate)
    create(:candidate_profile, candidate: candidate)
    invite = create(:invite, candidate: candidate, status: :accepted)
    selection_process = create(:selection_process, invite: invite)
    create(:company_profile, company: selection_process.company)
    message = create(:message, selection_process: selection_process,
                               sendable: selection_process.employee,
                               text: 'Venha fazer parte da nossa equipe!')
    create(:offer, selection_process: selection_process, message: message,
                   employee: selection_process.employee, status: :pending)

    login_as(selection_process.candidate, scope: :candidate)

    visit root_path
    click_on 'Convites'
    click_on 'Ver convite'

    expect(page).to have_content('PROPOSTA RECEBIDA! \o/')
    expect(page).to have_content('Parabéns! Você recebeu uma proposta. Agora'\
                                 ' avalie e veja se atende as suas'\
                                 ' expectativas')
    expect(page).to have_content('Venha fazer parte da nossa equipe!')
    expect(page).to have_link('Ver proposta')

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

    visit candidate_offer_path(candidate, selection_process, offer)
    click_on 'Aceitar Oferta'

    expect(page).to have_content('Oferta aceita!')
  end

  scenario 'and reject offer' do
  end
end
