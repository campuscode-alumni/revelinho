class CreateInterviews < ActiveRecord::Migration[6.0]
  def change
    create_table :interviews do |t|
      t.date :date,
      t.string :time_from,
      t.string :time_to,
      t.integer :format, default: '0'
      t.string :address
      t.references :selection_process, null: false, foreign_key: true

      t.timestamps
    end
  end
end
