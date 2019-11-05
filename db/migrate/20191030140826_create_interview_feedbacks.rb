class CreateInterviewFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :interview_feedbacks do |t|

      t.timestamps
    end
  end
end
