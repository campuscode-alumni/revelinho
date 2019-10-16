class CompanyProfile < ApplicationRecord
  belongs_to :company
  has_one_attached :logo

  validates :full_description, :benefits, :logo, presence: true, on: :update
end
