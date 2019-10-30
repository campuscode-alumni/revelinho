class AddEmployeeRefToInterviewFeedback < ActiveRecord::Migration[6.0]
  def change
    add_reference :interview_feedbacks, :employee, foreign_key: true
  end
end
