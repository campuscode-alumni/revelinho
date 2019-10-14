require 'rails_helper'

feature 'candidate register' do
  scenario 'successfully' do
    candidate = build(:candidate)

    visit root_path
    click_on 'Registre-se'
    fill_in 'Nome', with: candidate.name
    fill_in 'Cpf', with: candidate.cpf
    fill_in 'Endereço', with: candidate.address
    fill_in 'Telefone', with: candidate.phone
    fill_in 'Profissão', with: candidate.occupation
    fill_in 'Data de Nascimento', with: candidate.birthday
    fill_in 'Nível de Escolaridade', with: candidate.educational_level
    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar Senha', with: '123456'
    click_on 'Registrar'

    expect(page).to have_content 'Usuário registrado com sucesso'
  end
end
