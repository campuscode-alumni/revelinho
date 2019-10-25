class InterviewsController < ApplicationController
  before_action :set_interview, only: %i[accept reject]

  def accept
    @interview.scheduled!
  end

  def reject
    @interview.canceled!
  end

  private

  def set_interview
    @interview = Interview.find(params[:id])
  end
end
