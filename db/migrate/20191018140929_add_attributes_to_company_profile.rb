class AddAttributesToCompanyProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :company_profiles, :employees_number, :integer
    add_column :company_profiles, :website, :string
    add_column :company_profiles, :phone, :string
    add_column :company_profiles, :mission, :text
    add_column :company_profiles, :category, :string
    add_column :company_profiles, :attractives, :text
  end
end
