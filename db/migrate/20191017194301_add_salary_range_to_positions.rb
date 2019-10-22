class AddSalaryRangeToPositions < ActiveRecord::Migration[6.0]
  def change
    add_column :positions, :salary_from, :integer
    add_column :positions, :salary_to, :integer
  end
end
