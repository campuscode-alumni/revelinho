FactoryBot.define do
  factory :invite do
    position { nil }
    candidate { nil }
    message { 'Olá, ser humano. Venha fazer parte do nosso time' }
    status { 0 }
  end
end
