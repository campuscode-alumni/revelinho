class CreatePositions < ActiveRecord::Migration[6.0]
  def change
    create_table :positions do |t|
      t.string :title
      t.string :industry
      t.text :description
      t.decimal :salary
      t.integer :position_type

      t.timestamps
    end
  end
end
