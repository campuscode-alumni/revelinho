class CreateInvites < ActiveRecord::Migration[6.0]
  def change
    create_table :invites do |t|
      t.references :position, null: false, foreign_key: true
      t.references :candidate, null: false, foreign_key: true
      t.string :message
      t.integer :status, default: '0'

      t.timestamps
    end
  end
end
