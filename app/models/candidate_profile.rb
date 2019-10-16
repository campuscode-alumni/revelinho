class CandidateProfile < ApplicationRecord
  belongs_to :candidate
  validates :work_experience,
            :education,
            :skills,
            :coding_languages,
            :english_proficiency,
            :skype_username,
            :linkedin_profile_url,
            :github_profile_url, presence: true
end
