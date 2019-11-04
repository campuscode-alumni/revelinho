class Company < ApplicationRecord
  has_one :company_profile, dependent: :restrict_with_exception
  has_many :employees, dependent: :nullify
  has_many :positions, dependent: :nullify
  has_many :invites, through: :positions
  has_many :selection_processes, through: :invites
  has_many :interviews, through: :selection_processes

  enum status: { pending: 0, active: 10 }

  validates :name, :address, presence: true, on: :update
end
