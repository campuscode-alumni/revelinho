class RemoveSalaryFromPositions < ActiveRecord::Migration[6.0]
  def change

    remove_column :positions, :salary, :decimal
  end
end
