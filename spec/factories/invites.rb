FactoryBot.define do
  factory :invite do
    message { 'Olá, ser humano. Venha fazer parte do nosso time' }
    status { 0 }
    accepted_or_rejected_at { Date.current }
    candidate
    position
    employee
  end
end
