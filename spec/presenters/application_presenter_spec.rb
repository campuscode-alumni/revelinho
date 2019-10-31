require 'rails_helper'

describe 'ApplicationPresenter' do
  context '#nav_links' do
    it 'shows links for candidate' do
      candidate = create(:candidate)
      nav_links = ApplicationPresenter.new(candidate).nav_links

      expect(nav_links).to include('Candidato')
      expect(nav_links).to include('Ver perfil')
      expect(nav_links).to include('Sair')
    end

    it 'shows links for employee' do
      employee = create(:employee)
      nav_links = ApplicationPresenter.new(employee).nav_links

      expect(nav_links).to include('Posições')
      expect(nav_links).to include('Criar posição')
      expect(nav_links).to include('Empresa')
      expect(nav_links).to include('Ver empresa')
      expect(nav_links).to include('Editar perfil')
      expect(nav_links).to include('Sair')
    end

    it 'shows links for visitor' do
      nav_links = ApplicationPresenter.new.nav_links
      expect(nav_links).to include('Login funcionário')
      expect(nav_links).to include('Login candidato')
    end
  end
end
