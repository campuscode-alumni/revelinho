class Candidate < ApplicationRecord
  has_one :candidate_profile, dependent: :destroy
  has_many :invites, dependent: :destroy
  has_many :positions, through: :invites
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
end
