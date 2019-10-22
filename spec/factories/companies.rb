FactoryBot.define do
  factory :company do
    name { 'Acme Corp' }
    address { 'Acme Street 80' }
    url_domain { 'acme.com' }
    status { 'pending' }

    trait :active do
      status { :active }
    end
  end
end
