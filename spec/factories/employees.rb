FactoryBot.define do
  factory :employee do
    sequence(:email) { |n| "renata#{n}@empresa.com" }
    password { '1234567' }
    company
  end
end
