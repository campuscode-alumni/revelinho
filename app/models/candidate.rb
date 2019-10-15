class Candidate < ApplicationRecord
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

  enum status: { published: 0, hidden: 10 }
end
