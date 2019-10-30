require 'rails_helper'

describe CompanyProfileDecorator do
  context '#company_profile_link' do
    it 'has to present an edit link if company profile exists' do
      company = create(:company)
      create(:company_profile, company: company)
      company_link = CompanyProfileDecorator.decorate(company)
                                            .company_profile_link

      expect(company_link).to include('Editar perfil da empresa')
    end

    it 'has to present a create link if company profile does not exist' do
      company = create(:company)
      company_link = CompanyProfileDecorator.decorate(company)
                                            .company_profile_link

      expect(company_link).to include('Completar perfil da empresa')
    end
  end
end
