FactoryBot.define do
  factory :candidate_profile do
    work_experience { "MyText" }
    education { "MyText" }
    skills { "MyText" }
    coding_languages { "MyText" }
    english_proficiency { "MyString" }
    skype_username { "MyString" }
    linkedin_profile_url { "MyString" }
    github_profile_url { "MyString" }
    candidate { nil }
  end
end
