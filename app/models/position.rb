class Position < ApplicationRecord
  belongs_to :company
  enum position_type: { full_time: 0, part_time: 10, internship: 30, contractor: 40 }
end
