FactoryBot.define do
  factory :invite do
    message { 'Olá, ser humano. Venha fazer parte do nosso time' }
    status { 0 }
    candidate
    position
  end
end
