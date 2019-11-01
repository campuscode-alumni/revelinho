FactoryBot.define do
  factory :candidate_profile do
    work_experience { 'Revelo' }
    education { 'Faculdade X' }
    skills { 'Scrum' }
    coding_languages { 'Ruby' }
    english_proficiency { 'Fluente' }
    skype_username { 'candidate.skype' }
    linkedin_profile_url { 'https://www.linkedin.com/in/candidate' }
    github_profile_url { 'https://github.com/candidate' }
    candidate { nil }

    avatar do
      fixture_file_upload(Rails.root.join('spec', 'support', 'images',
                                          'gatinho.jpg'), 'image/jpg')
    end

    trait :with_candidate do
      candidate
    end
  end
end
