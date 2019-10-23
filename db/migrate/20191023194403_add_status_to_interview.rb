class AddStatusToInterview < ActiveRecord::Migration[6.0]
  def change
    add_column :interviews, :status, :integer, default: '0'
  end
end
