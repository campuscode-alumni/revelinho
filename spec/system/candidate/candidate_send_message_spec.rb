require 'rails_helper'

feature 'candidate messages exchanges' do
  context 'send message' do
    scenario 'successfully' do
      candidate = create(:candidate, status: :published)
      create(:candidate_profile, candidate: candidate)
      position = create(:position)
      position.company.company_profile = create(:company_profile)
      create(:invite, candidate: candidate, position: position,
                      status: :pending)

      login_as(candidate, scope: :candidate)
      visit root_path
      click_on 'Convites'

      click_link('Aceitar')

      fill_in 'Escreva a sua mensagem', with: 'Olá, meu nome é João'
      click_on('Enviar')

      expect(page).to have_css('h5', text: candidate.name)
      expect(page).to have_content('Olá, meu nome é João')
    end

    scenario 'and validate empty field' do
      candidate = create(:candidate, status: :published)
      create(:candidate_profile, candidate: candidate)
      position = create(:position, title: 'Desenvolvedor')
      position.company.company_profile = create(:company_profile)
      invite = create(:invite, candidate: candidate,
                               position: position, status: :accepted)
      invite.create_selection_process

      login_as(candidate, scope: :candidate)
      visit root_path
      click_on 'Convites'
      click_on 'Ver convite'

      fill_in 'Escreva a sua mensagem', with: ''
      click_on('Enviar')

      expect(page).to have_content('Não foi possivel enviar mensagem.'\
                                   ' Tente novamente')
    end
  end

  context 'see company details' do
    scenario 'with main employee' do
      candidate = create(:candidate, status: :published)
      create(:candidate_profile, candidate: candidate)
      employee = create(:employee, name: 'João Silva',
                                   email: 'joao.silva@revelo.com.br')
      employee.company.company_profile = create(:company_profile,
                                                phone: '11 11111111')

      position = create(:position, company: employee.company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :accepted, employee: employee)
      invite.create_selection_process

      login_as(candidate, scope: :candidate)
      visit root_path

      click_on 'Convites'
      click_on 'Ver convite'

      expect(page).to have_css('small', text: 'João Silva')
      expect(page).to have_css('small', text: 'Telefone: 11 11111111')
      expect(page).to have_css('small', text: 'Email: joao.silva@revelo.com.br')
    end
  end
end
