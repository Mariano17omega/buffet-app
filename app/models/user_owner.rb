class UserOwner < ApplicationRecord
  has_one :buffet # associação de um-para-um,pq o usuario só pode ter um buffet

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
