class AddOfficeHoursToPosition < ActiveRecord::Migration[6.0]
  def change
    add_column :positions, :office_hours, :integer
  end
end
