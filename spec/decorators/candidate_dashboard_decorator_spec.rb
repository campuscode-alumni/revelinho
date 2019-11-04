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

      expect(candidate_decorator.info_header_text).to include(
        'Seu perfil está ativo'
      )
      expect(candidate_decorator.info_header_text).to include(
        'Aguarde o contato das empresas'
      )
    end

    it 'has to show info header text when not published' do
      candidate = create(:candidate, status: :hidden)
      candidate_decorator = CandidateDashboardDecorator.new(candidate)

      expect(candidate_decorator.info_header_text).to include(
        'Seu perfil ainda não está ativo'
      )
      expect(candidate_decorator.info_header_text).to include(
        'Complete-o e fique visível'
      )
      expect(candidate_decorator.info_header_text).to include(
        'href="/candidate_profiles/new"'
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
