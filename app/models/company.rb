class Company < ApplicationRecord
  has_many :employees, dependent: :destroy
  has_many :positions, dependent: :destroy

  enum status: { pending: 0, active: 10 }
end
