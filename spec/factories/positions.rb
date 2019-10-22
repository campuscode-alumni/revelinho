FactoryBot.define do
  factory :position do
    title { 'Desenvolvedor' }
    industry { 'TI' }
    description { 'Desenvolvedor Ruby' }
    salary { '3000.00' }
    position_type { 'full_time' }

    trait :with_company do
      company
    end
  end
end
