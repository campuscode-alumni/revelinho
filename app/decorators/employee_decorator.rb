class EmployeeDecorator < ApplicationDecorator
  delegate_all

  def full_name
    ""
  end
end
