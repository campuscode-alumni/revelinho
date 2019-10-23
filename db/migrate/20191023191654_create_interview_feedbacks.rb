class CreateInterviewFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :interview_feedbacks do |t|
      t.string :message
      t.references :interview, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
