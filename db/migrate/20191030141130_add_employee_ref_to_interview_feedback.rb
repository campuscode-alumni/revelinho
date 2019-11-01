class AddEmployeeRefToInterviewFeedback < ActiveRecord::Migration[6.0]
  def change
    add_reference :interview_feedbacks, :employee, polymorphic: true
  end
end
