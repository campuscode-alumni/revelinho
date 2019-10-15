class AddBirthdayToCandidate < ActiveRecord::Migration[6.0]
  def change
    add_column :candidates, :birthday, :string
  end
end
