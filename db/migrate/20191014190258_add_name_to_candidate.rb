class AddNameToCandidate < ActiveRecord::Migration[6.0]
  def change
    add_column :candidates, :name, :string
  end
end
