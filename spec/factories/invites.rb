FactoryBot.define do
  factory :invite do
    message { 'Olá, ser humano. Venha fazer parte do nosso time' }
    status { :pending }
    candidate
    position

    trait :accepted do
      status { :accepted }
    end

    trait :pending do
      status { :pending }
    end
  end
end
