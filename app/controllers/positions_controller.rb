class PositionsController < ApplicationController
  def new
    @position = Position.new
  end

  def create
    @position = Position.new(params.require(:position).permit(:title, :industry, :salary, :position_type, :description))
    @position.company = current_employee.company
    if @position.save
      redirect_to @position
    else
      render :new
    end
  end

  def show
    @position = Position.find(params[:id])
  end
end
