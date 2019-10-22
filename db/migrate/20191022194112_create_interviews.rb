class CreateInterviews < ActiveRecord::Migration[6.0]
  def change
    create_table :interviews do |t|
      t.datetime :datetime
      t.integer :format, default: '0'
      t.string :address
      t.references :selection_process, null: false, foreign_key: true

      t.timestamps
    end
  end
end
