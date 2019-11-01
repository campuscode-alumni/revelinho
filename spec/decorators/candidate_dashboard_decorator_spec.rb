require 'rails_helper'

RSpec.describe CandidateDashboardDecorator do
  context '#header_text' do
    it 'has to show header text' do
      candidate = create(:candidate)
      candidate_decorator = CandidateDashboardDecorator.new(candidate)

      expect(candidate_decorator.header_text).to eq 'Olá John Doe!'
    end
  end

  context '#info_header_text' do
    it 'has to show info header text when published' do
      candidate = create(:candidate, status: :published)
      create(:candidate_profile, candidate: candidate)
      candidate_decorator = CandidateDashboardDecorator.new(candidate)

      expect(candidate_decorator.info_header_text).to(
        include 'Seu perfil está ativo. Aguarde o contato das empresas '\
           'interessadas.'
      )
      expect(candidate_decorator.info_header_text).to(include 'Editar Perfil')
      expect(candidate_decorator.info_header_text).to(include 'Ver seu perfil')
    end

    it 'has to show info header text when not published' do
      candidate = create(:candidate, status: :hidden)
      candidate_decorator = CandidateDashboardDecorator.new(candidate)

      expect(candidate_decorator.info_header_text).to(
        eq '<p>Seu perfil ainda não está ativo. Complete-o e fique visível '\
           'para as empresas.</p><a class="btn btn-primary btn-large" href'\
           '="/candidate_profiles/new">Concluir'\
           ' perfil</a>'
      )
    end
  end

  context '#card_render' do
    it 'has to show cards when published' do
      candidate = create(:candidate, status: :published)
      candidate_decorator = CandidateDashboardDecorator.new(candidate)

      response = candidate_decorator.card_render

      expect(response).to include 'href="invites"'
      expect(response).to include 'Convites'
      expect(response).to include 'fa-envelope-open-text'
      expect(response).to include '<span>0</span>'
    end

    it 'has to show nothing when not published' do
      candidate = create(:candidate, status: :hidden)
      candidate_decorator = CandidateDashboardDecorator.new(candidate)

      response = candidate_decorator.card_render

      expect(response).to eq ''
    end
  end
end
