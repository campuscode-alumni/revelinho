class Position < ApplicationRecord
  has_many :candidates, through: :invites
  belongs_to :company
  has_many :invites, dependent: :nullify

  enum position_type: { full_time: 0, part_time: 10, internship: 30,
                        contractor: 40 }

  validates :title, :industry, :description, :salary_from, :salary_to,
            :position_type, presence: true
end
