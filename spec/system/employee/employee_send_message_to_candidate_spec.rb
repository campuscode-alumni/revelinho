require 'rails_helper'

feature 'employee send message' do
  scenario 'successfully' do
    company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
    company.company_profile = create(:company_profile)
    candidate = create(:candidate, status: :published)
    employee = create(:employee, company: company)
    position = create(:position, company: company)
    invite = create(:invite, candidate: candidate, position: position,
                             status: :pending)
    invite.create_selection_process

    login_as(employee, scope: :employee)
    visit selection_process_path(invite.selection_process)

    fill_in 'Escreva a sua mensagem', with: 'Seja bem vindo!'
    click_on('Enviar')
    fill_in 'Escreva a sua mensagem', with: 'Podemos agendar uma entrevista?'
    click_on('Enviar')

    expect(page).to have_css('h5', text: employee.email)
    expect(page).to have_content('Seja bem vindo!')
    expect(page).to have_content('Podemos agendar uma entrevista?')
  end

  scenario 'and validate empty field' do
    company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
    company.company_profile = create(:company_profile)
    candidate = create(:candidate, status: :published)
    employee = create(:employee, company: company)
    position = create(:position, company: company)
    invite = create(:invite, candidate: candidate, position: position,
                             status: :pending)
    invite.create_selection_process

    login_as(employee, scope: :employee)
    visit selection_process_path(invite.selection_process)

    fill_in 'Escreva a sua mensagem', with: ''
    click_on('Enviar')

    expect(page).to have_content('Não foi possivel enviar mensagem.'\
                                 ' Tente novamente')
  end
end
