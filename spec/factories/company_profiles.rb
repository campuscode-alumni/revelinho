FactoryBot.define do
  factory :company_profile do
    company
    full_description { 'Emprega pessoase faz uns serviços' }
    benefits { 'vt e vr' }

    trait :with_blank_field do
      benefits { nil }
      full_description { nil }
      logo { nil }
    end
  end
end
