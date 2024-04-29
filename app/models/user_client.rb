class UserClient < ApplicationRecord
  attr_accessor :name, :cpf
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile
  accepts_nested_attributes_for :profile


  #validates :name, presence: true
  #validates :cpf, presence: true, uniqueness: true


  #validates :cpf, :cpf => true
  #validate :cpf_is_valid

  private

  #def cpf_is_valid
    #cpf = CPF.new(self.cpf)
    #unless cpf.valid?
    #  errors.add(:cpf, "CPF invalido")
    #end

  #end


end
