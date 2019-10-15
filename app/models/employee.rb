class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :company, optional: true
  after_create :company_exists

  private

  def get_company(name, domain)
    Company.find_by(url_domain: domain) || Company.create(name: name, url_domain: domain)
  end

  def company_exists
    company_domain = email.split('@')[1]
    company_name = company_domain.split('.')[0].humanize
    company = get_company(company_name, company_domain)

    update(company: company)
  end
end
