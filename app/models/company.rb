class Company < ApplicationRecord
  has_many :employees, dependent: :destroy 
  has_many :positions, dependent: :destroy
end
