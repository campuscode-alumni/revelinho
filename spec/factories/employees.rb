FactoryBot.define do
  factory :employee do
    name { 'João Silva' }
    sequence(:email) { |n| "renata#{n}@empresa.com" }
    password { '1234567' }
    company
    avatar do
      fixture_file_upload(Rails.root.join('spec', 'support', 'images',
                                          'gatinho.jpg'), 'image/jpg')
    end

    trait :without_avatar do
      avatar { nil }
    end
  end
end
