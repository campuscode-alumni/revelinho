class CreateCompanyProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :company_profiles do |t|
      t.string :full_description
      t.string :benefits

      t.timestamps
    end
  end
end
