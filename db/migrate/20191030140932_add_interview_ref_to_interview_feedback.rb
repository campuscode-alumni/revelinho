class AddInterviewRefToInterviewFeedback < ActiveRecord::Migration[6.0]
  def change
    add_reference :interview_feedbacks, :interview, foreign_key: true
  end
end
