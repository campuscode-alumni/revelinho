class CreateSelectionProcesses < ActiveRecord::Migration[6.0]
  def change
    create_table :selection_processes do |t|
      t.references :invite, foreign_key: true

      t.timestamps
    end
  end
end
