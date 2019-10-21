class CompanyProfile < ApplicationRecord
  belongs_to :company
  has_one_attached :logo
  validates :company_id, uniqueness: true
end
