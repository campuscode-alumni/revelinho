class CompanyProfile < ApplicationRecord
  has_one :company, dependent: :destroy
end
