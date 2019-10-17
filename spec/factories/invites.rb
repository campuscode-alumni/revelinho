FactoryBot.define do
  factory :invite do
    position { nil }
    candidate { nil }
    salary_from { 1 }
    salary_to { 1 }
    message { "MyString" }
    position_type { 1 }
  end
end
