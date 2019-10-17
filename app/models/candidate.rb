class Candidate < ApplicationRecord
  has_one :candidate_profile, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name,
            :address,
            :phone,
            :occupation,
            :educational_level,
            :cpf,
            :birthday, presence: true

  enum status: { hidden: 0, published: 10 }
end
