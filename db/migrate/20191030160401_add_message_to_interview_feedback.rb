class AddMessageToInterviewFeedback < ActiveRecord::Migration[6.0]
  def change
    add_column :interview_feedbacks, :message, :string
  end
end
