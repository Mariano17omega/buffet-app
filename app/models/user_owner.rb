class UserOwner < ApplicationRecord
  has_one :buffet
  has_many :orders, through: :buffet

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
