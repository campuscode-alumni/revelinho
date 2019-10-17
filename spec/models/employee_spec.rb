require 'rails_helper'

describe Employee do
  context '#create_company' do
    it 'has to create company if not exists' do
      employee = build(:employee, email: 'joao.silva@revelo.com.br',
                                  company: nil)

      employee.save

      expect(employee.company.name).to eq 'Revelo'
      expect(employee.company.url_domain).to eq 'revelo.com.br'
    end

    it 'not create company if already exists' do
      create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      employee = build(:employee, email: 'joao.silva@revelo.com.br',
                                  company: nil)

      expect { employee.save }.not_to(change { Company.count })
      expect(Company.count).to eq 1
    end
  end
end
