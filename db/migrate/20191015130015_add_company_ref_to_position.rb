class AddCompanyRefToPosition < ActiveRecord::Migration[6.0]
  def change
    add_reference :positions, :company, foreign_key: true
  end
end
