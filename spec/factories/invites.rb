FactoryBot.define do
  factory :invite do
    position { nil }
    candidate { nil }
    salary_from { 1 }
    salary_to { 1 }
    position_type { 1 }
    message { 'Olá, ser humano. Venha fazer parte do nosso time' }
    status { 0 }
  end
end
