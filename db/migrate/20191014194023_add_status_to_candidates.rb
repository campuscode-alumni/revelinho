class AddStatusToCandidates < ActiveRecord::Migration[6.0]
  def change
    add_column :candidates, :status, :integer, default: '0'
  end
end
