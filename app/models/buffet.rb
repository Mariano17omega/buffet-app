class Buffet < ApplicationRecord
  belongs_to :user_owner
  has_many :events
  has_one :payment_method
  has_many :orders, through: :events

  validates :corporate_name, :brand_name, :cnpj, :contact_phone,
  :contact_email, :address, :district, :state, :city, :cep,
  :description, presence: true

  validates :corporate_name, :brand_name, :cnpj, :contact_phone,
  :contact_email, :description, uniqueness: true

  validates  :cnpj, cnpj: true

  accepts_nested_attributes_for :payment_method


end
