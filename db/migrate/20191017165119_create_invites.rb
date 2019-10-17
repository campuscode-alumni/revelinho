class CreateInvites < ActiveRecord::Migration[6.0]
  def change
    create_table :invites do |t|
      t.references :position, null: false, foreign_key: true
      t.references :candidate, null: false, foreign_key: true
      t.integer :salary_from
      t.integer :salary_to
      t.string :message
      t.integer :position_type

      t.timestamps
    end
  end
end
