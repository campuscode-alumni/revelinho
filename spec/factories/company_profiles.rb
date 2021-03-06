FactoryBot.define do
  factory :company_profile do
    company
    full_description { 'Emprega pessoas e faz uns serviços' }
    benefits { 'vt e vr' }
    employees_number { '100-500' }
    website { 'revelo.com.br' }
    phone { '11 3030-3030' }
    mission { 'Empregar pessoas' }
    category { 'RH' }
    attractives { 'Ambiente informal e as vezes tem fruta' }

    logo do
      fixture_file_upload(Rails.root.join('spec', 'support', 'images',
                                          'gatinho.jpg'), 'image/jpg')
    end

    trait :with_blank_field do
      benefits { nil }
      full_description { nil }
      logo { nil }
      employees_number { nil }
      website { nil }
      phone { nil }
      mission { nil }
      category { nil }
      attractives { nil }
    end

    trait :without_logo do
      logo { nil }
    end
  end
end
