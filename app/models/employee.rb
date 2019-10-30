class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :company, optional: true
  has_many :candidate_notes, dependent: :nullify
  has_many :messages, as: :sendable, dependent: :nullify
  has_one_attached :avatar

  after_create :set_company

  validates :name, presence: true

  private

  def get_company(email)
    domain = email.split('@')[1]

    Company.find_or_create_by(url_domain: domain) do |company|
      company.name = domain.split('.')[0].humanize
    end
  end

  def set_company
    return if company.present?

    update(company: get_company(email))
  end
end
