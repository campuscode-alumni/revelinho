class CompanyProfile < ApplicationRecord
  has_one :company, dependent: :destroy
  has_one_attached :logo
end
