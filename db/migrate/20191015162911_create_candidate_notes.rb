class CreateCandidateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :candidate_notes do |t|
      t.string :comment
      t.references :employee, null: false, foreign_key: true
      t.references :candidate, null: false, foreign_key: true
      t.integer :visibility, default: '0'

      t.timestamps
    end
  end
end
