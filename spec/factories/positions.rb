FactoryBot.define do
  factory :position do
    title { 'Desenvolvedor' }
    industry { 'TI' }
    description { 'Desenvolvedor Ruby' }
    salary_from { 4500 }
    salary_to { 5500 }
    office_hours { :full_time }
    hiring_scheme { :clt }
    company
  end
end
