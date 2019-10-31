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
                   start_date: '30-10-2019', salary: 3500.00)

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

    mailer_spy = class_spy('OfferMailer')
    stub_const('OfferMailer', mailer_spy)
    mail = double
    allow(mailer_spy).to receive(:notify_accepted).and_return(mail)
    allow(mail).to receive(:deliver_now).and_return(nil)

    login_as(candidate, scope: :candidate)

    visit selection_process_candidates_path(selection_process)
    click_on 'Aceitar proposta'

    offer_id = selection_process.offers.last.id
    expect(mailer_spy).to have_received(:notify_accepted).with(offer_id)

    offer.reload

    expect(page).to have_content('Oferta aceita!')
    expect(page).to have_content('Agora é só aguardar o contato de sua nova '\
                                 'casa!')
    expect(page).to have_content('Nós da Revelinho desejamos muito sucesso em '\
                                 'sua carreira. :D')
    expect(selection_process.messages.last.text).to eq 'Oferta aceita!'
    expect(offer).to be_accepted
  end

  scenario 'and reject offer' do
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

    mailer_spy = class_spy('OfferMailer')
    stub_const('OfferMailer', mailer_spy)
    mail = double
    allow(mailer_spy).to receive(:notify_rejected).and_return(mail)
    allow(mail).to receive(:deliver_now).and_return(nil)

    login_as(candidate, scope: :candidate)

    visit selection_process_candidates_path(selection_process)
    click_on 'Rejeitar proposta'

    offer.reload

    offer_id = selection_process.offers.last.id
    expect(mailer_spy).to have_received(:notify_rejected).with(offer_id)

    expect(page).to have_content('Oferta rejeitada!')
    expect(selection_process.messages.last.text).to eq 'Oferta rejeitada!'
    expect(offer).to be_rejected
  end
end
