class Position < ApplicationRecord
  has_many :candidates, through: :invites
  belongs_to :company
  has_many :invites, dependent: :nullify

  enum hiring_scheme: { clt: 0, contractor: 5, internship: 10 }
  enum office_hours: { full_time: 0, part_time: 10 }

  validates :title, :industry, :description, :salary_from, :salary_to,
            :hiring_scheme, :office_hours, presence: true
end
