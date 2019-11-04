require 'rails_helper'

describe CompanyProfileDecorator do
  context '#company_profile_link' do
    it 'has to present a create link if company profile does not exist' do
      company = create(:company)
      company_link = CompanyProfileDecorator.decorate(company)
                                            .company_profile_link

      expect(company_link).to include('Completar perfil da empresa')
    end
  end

  context '#card_render' do
    it 'shows pending invites count' do
      company = create(:company, url_domain: 'revelo.com.br')
      candidate1 = create(:candidate)
      candidate2 = create(:candidate)
      candidate3 = create(:candidate)
      create(:candidate_profile, candidate: candidate1)
      create(:candidate_profile, candidate: candidate2)
      create(:candidate_profile, candidate: candidate3)
      position = create(:position, title: 'Engenheiro de Software Pleno',
                                   company: company)
      create(:invite, position: position,
                      candidate: candidate1)
      create(:invite, position: position,
                      candidate: candidate2)
      create(:invite, :accepted, position: position,
                                 candidate: candidate3)
      card_render = CompanyProfileDecorator.decorate(company).card_render

      expect(card_render).to include('2')
      expect(card_render).to include('Convites')
    end
  end
end
