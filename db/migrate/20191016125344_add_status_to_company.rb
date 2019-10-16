class AddStatusToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :status, :integer, default: '0'
  end
end
