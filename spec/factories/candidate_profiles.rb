FactoryBot.define do
  factory :candidate_profile do
    work_experience { "Revelo" }
    education { "Faculdade X" }
    skills { "Scrum" }
    coding_languages { "Ruby" }
    english_proficiency { "Fluente" }
    skype_username { "candidate.skype" }
    linkedin_profile_url { "https://www.linkedin.com/in/candidate" }
    github_profile_url { "https://github.com/candidate" }
    candidate { nil }
  end
end
