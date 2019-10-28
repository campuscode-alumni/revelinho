class Candidate < ApplicationRecord
  has_one :candidate_profile, dependent: :destroy
  has_many :invites, dependent: :nullify
  has_many :positions, through: :invites
  has_many :messages, as: :sendable, dependent: :nullify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :candidate_notes, dependent: :destroy

  validates :name,
            :address,
            :phone,
            :occupation,
            :educational_level,
            :cpf,
            :city,
            :state,
            :country,
            :zip_code,
            :birthday, presence: true

  enum status: { hidden: 0, published: 10 }

  delegate :avatar, to: :candidate_profile
end
