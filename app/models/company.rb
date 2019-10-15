class Company < ApplicationRecord
  has_many :employees, dependent: :nullify
end
