class AddLocationAttributesToCandidates < ActiveRecord::Migration[6.0]
  def change
    add_column :candidates, :city, :string
    add_column :candidates, :state, :string
    add_column :candidates, :country, :string
    add_column :candidates, :zip_code, :string
  end
end
