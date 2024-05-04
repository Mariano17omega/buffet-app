class Profile < ApplicationRecord
  belongs_to :user_client

  validates  :name, :cpf, presence: true
  validates  :cpf, uniqueness: true
  validates  :cpf, cpf: true

end
