class AddCompanyProfileRefToCompany < ActiveRecord::Migration[6.0]
  def change
    add_reference :companies, :company_profile, foreign_key: true
  end
end
