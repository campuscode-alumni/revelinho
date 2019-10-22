class AddCompanyRefToCompanyProfile < ActiveRecord::Migration[6.0]
  def change
    add_reference :company_profiles, :company, foreign_key: true
  end
end
