class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.float :salary
      t.integer :hiring_scheme
      t.date :start_date
      t.integer :status, default: '0'
      t.references :employee, foreign_key: true
      t.references :selection_process, foreign_key: true
      t.references :message, foreign_key: true

      t.timestamps
    end
  end
end
