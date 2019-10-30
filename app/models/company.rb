class Company < ApplicationRecord
  has_one :company_profile, dependent: :destroy
  has_many :employees, dependent: :nullify
  has_many :positions, dependent: :nullify
  has_many :invites, through: :positions

  enum status: { pending: 0, active: 10 }

  validates :name, :address, presence: true, on: :update
end
