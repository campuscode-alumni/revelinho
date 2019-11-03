require 'rails_helper'

feature 'candidate register' do
  scenario 'successfully' do
    candidate = build(:candidate)

    visit root_path
    click_on 'Login/Cadastro'
    click_on 'Candidato'
    click_on 'Inscrever-se'
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
    fill_in 'Cidade', with: 'Manaus'
    fill_in 'Estado', with: 'Amazonas'
    fill_in 'País', with: 'Brasil'
    fill_in 'CEP', with: '02765-030'
    click_on 'Registrar'

    expect(page).to have_content 'Bem vindo! Você realizou seu registro '\
                                  'com sucesso'
  end

  scenario 'failed' do
    candidate = build(:candidate)

    visit root_path
    click_on 'Login/Cadastro'
    click_on 'Candidato'
    click_on 'Inscrever-se'
    fill_in 'Nome', with: candidate.name
    fill_in 'Endereço', with: candidate.address
    fill_in 'Telefone', with: candidate.phone
    fill_in 'Profissão', with: candidate.occupation
    fill_in 'Data de Nascimento', with: candidate.birthday
    fill_in 'Nível de Escolaridade', with: candidate.educational_level
    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar Senha', with: '123456'
    click_on 'Registrar'

    expect(page).to have_content 'Não foi possível salvar o candidato'
  end

  scenario 'and logout successfully' do
    candidate = create(:candidate, password: '123456')
    create(:candidate_profile, candidate: candidate)

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Logout'

    expect(page).to have_content 'Logout efetuado com sucesso'
  end
end
