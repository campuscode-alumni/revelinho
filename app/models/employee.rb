class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :create_company

  private

  def create_company
    company_domain = email.split('@')[1]
    company_name = company_domain.split('.')[0].humanize

    Company.create(name: company_name, url_domain: company_domain)
  end

  def company_exists
  end
end
