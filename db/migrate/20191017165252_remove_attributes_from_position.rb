class RemoveAttributesFromPosition < ActiveRecord::Migration[6.0]
  def change

    remove_column :positions, :salary, :decimal

    remove_column :positions, :position_type, :integer
  end
end
