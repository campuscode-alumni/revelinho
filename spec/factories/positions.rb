FactoryBot.define do
  factory :position do
    title { 'MyString' }
    industry { 'MyString' }
    description { 'MyText' }
    salary_from { 4500 }
    salary_to { 5500 }
    position_type { :full_time }
    company
  end
end
