require 'rails_helper'

feature 'employee send offer to candidate' do
  scenario 'succesfully' do
    selection_process = create(:selection_process)
    create(:company_profile, company: selection_process.company)

    login_as(selection_process.employee, scope: :employee)

    visit selection_process_candidates_path(selection_process)
    click_on 'Quero contrata-lo!'

    fill_in 'Salário', with: '2.500,00'
    select 'CLT', from: 'Regime de contratação'
    fill_in 'Data de início', with: '11/11/2019'
    fill_in 'Mensagem', with: 'Venha fazer parte do nosso time!'
    click_on('Enviar proposta')

    expect(page).to have_content('Proposta realizada! Aguardando retorno do '\
                                 'candidato.')
    expect(selection_process.offers.count).to eq 1
  end
end
