require 'rails_helper'

feature 'employee send offer to candidate' do
  scenario 'succesfully' do
    selection_process = create(:selection_process)
    create(:company_profile, company: selection_process.company)

    mailer_spy = class_spy('OfferMailer')
    stub_const('OfferMailer', mailer_spy)
    mail = double
    allow(mailer_spy).to receive(:notify_candidate).and_return(mail)
    allow(mail).to receive(:deliver_now).and_return(nil)

    login_as(selection_process.employee, scope: :employee)

    visit selection_process_candidates_path(selection_process)
    click_on 'Quero contrata-lo!'

    fill_in 'Salário', with: '2.500,00'
    select 'CLT', from: 'Regime de contratação'
    fill_in 'Data de início', with: '11/11/2019'
    fill_in 'Mensagem', with: 'Venha fazer parte do nosso time!'
    click_on('Enviar proposta')

    selection_process.reload

    offer_id = selection_process.offers.last.id
    expect(mailer_spy).to have_received(:notify_candidate).with(offer_id)

    expect(page).to have_content('Proposta realizada! Aguardando retorno do '\
                                 'candidato.')
    expect(selection_process.offers.count).to eq 1
  end

  scenario 'with validate fields' do
    selection_process = create(:selection_process)
    create(:company_profile, company: selection_process.company)

    mailer_spy = class_spy('OfferMailer')
    stub_const('OfferMailer', mailer_spy)
    mail = double
    allow(mailer_spy).to receive(:notify_candidate).and_return(mail)
    allow(mail).to receive(:deliver_now).and_return(nil)

    login_as(selection_process.employee, scope: :employee)

    visit selection_process_candidates_path(selection_process)
    click_on 'Quero contrata-lo!'

    fill_in 'Salário', with: ''
    select 'CLT', from: ''
    fill_in 'Data de início', with: ''
    fill_in 'Mensagem', with: ''
    click_on('Enviar proposta')

    selection_process.reload

    expect(mailer_spy).not_to have_received(:notify_candidate)

    expect(page).not_to have_content('Proposta realizada! Aguardando retorno '\
                                     'do candidato.')
    expect(selection_process.offers.count).to eq 0
  end
end
