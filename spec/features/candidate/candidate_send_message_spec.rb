require 'rails_helper'

feature 'candidate messages exchanges' do
  context 'send message' do
    scenario 'successfully' do
      candidate = create(:candidate, status: :published)
      create(:candidate_profile, candidate: candidate)
      position = create(:position)
      position.company.company_profile = create(:company_profile)
      create(:invite, candidate: candidate, position: position, status: :pending)
  
      login_as(candidate, scope: :candidate)
      visit root_path
      click_on 'Convites'
  
      click_link('Aceitar')
  
      fill_in 'Escreva a sua mensagem', with: 'Olá, meu nome é João'
      click_on('Enviar')
  
      expect(page).to have_css('h5', text: candidate.email)
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
      position = create(:position)
      position.company.company_profile = create(:company_profile)
      create(:invite, candidate: candidate, position: position, status: :pending)
  
      login_as(candidate, scope: :candidate)
      visit root_path
      click_on 'Convites'
  
      click_link('Aceitar')
  
      fill_in 'Escreva a sua mensagem', with: 'Olá, meu nome é João'
      click_on('Enviar')
  
      expect(page).to have_css('h5', text: candidate.email)
      expect(page).to have_content('Olá, meu nome é João')
    end
  end
end
