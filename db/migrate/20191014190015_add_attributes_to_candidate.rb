class AddAttributesToCandidate < ActiveRecord::Migration[6.0]
  def change
    add_column :candidates, :name, :string
    add_column :candidates, :address, :string
    add_column :candidates, :phone, :string
    add_column :candidates, :occupation, :string
    add_column :candidates, :educational_level, :string
  end
end
