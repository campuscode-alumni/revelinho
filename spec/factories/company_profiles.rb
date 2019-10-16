include ActionDispatch::TestProcess
FactoryBot.define do
  factory :company_profile do
    full_description { 'MyString' }
    benefits { 'MyString' }
    logo do
      fixture_file_upload(Rails.root.join('spec', 'support', 'images',
                                          'gatinho.jpg'))
    end
  end
end
