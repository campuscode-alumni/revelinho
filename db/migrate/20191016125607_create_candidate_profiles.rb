class CreateCandidateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :candidate_profiles do |t|
      t.text :work_experience
      t.text :education
      t.text :skills
      t.text :coding_languages
      t.string :english_proficiency
      t.string :skype_username
      t.string :linkedin_profile_url
      t.string :github_profile_url
      t.references :candidate, foreign_key: true

      t.timestamps
    end
  end
end
