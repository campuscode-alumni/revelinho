class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :selection_process, null: false, foreign_key: true
    end
  end
end
