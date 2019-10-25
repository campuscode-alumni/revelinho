class AddHiringSchemeToPosition < ActiveRecord::Migration[6.0]
  def change
    add_column :positions, :hiring_scheme, :integer
  end
end
