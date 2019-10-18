class Position < ApplicationRecord
  belongs_to :company, dependent: :destroy
  has_many :invites, dependent: :destroy

  enum position_type: { full_time: 0, part_time: 10, internship: 30,
                        contractor: 40 }

  validates :title, :industry, :description, :salary, :position_type,
            presence: true
end
