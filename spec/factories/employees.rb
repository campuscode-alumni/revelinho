FactoryBot.define do
  factory :employee do
    email { 'employee@company.com' }
    password { '123456' }
    company
  end
end
