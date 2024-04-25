class Buffet < ApplicationRecord
  belongs_to :user_owner
  validates :corporate_name, :brand_name, :cnpj, :contact_phone,
  :contact_email, :address, :district, :state, :city, :cep,
  :description, :playment_methods, presence: true
  validates :corporate_name, :brand_name, :cnpj, :contact_phone,
  :contact_email, :description, uniqueness: true
end
