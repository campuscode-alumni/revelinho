FactoryBot.define do
  factory :candidate do
    name { 'John Doe' }
    sequence(:email) { |n| "jose#{n}@candidato.com" }
    password { '12345678' }
    cpf { '1234567890' }
    address { 'Rua Revelada, 10' }
    occupation { 'full stack developer' }
    educational_level { 'post-doc' }
    city { 'São Paulo' }
    state { 'São Paulo' }
    country { 'Brasil' }
    zip_code { '03267-080' }
    status { :published }
    phone { '11970707070' }
    birthday { '12/12/1960' }

    trait :hidden do
      status { :hidden }
    end
  end
end
