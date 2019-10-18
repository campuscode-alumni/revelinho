FactoryBot.define do
  factory :position do
    title { 'MyString' }
    industry { 'MyString' }
    description { 'MyText' }
    salary { '9.99' }
    position_type { 'full_time' }

    trait :with_company do
      company
    end
  end
end
