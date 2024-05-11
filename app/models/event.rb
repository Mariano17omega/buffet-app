class Event < ApplicationRecord
  belongs_to :buffet
  has_one :price, dependent: :destroy
  has_many :orders

  validates :name, :description, :min_guests, :duration, :menu, presence: true
  validates :name, uniqueness: true

  accepts_nested_attributes_for :price, allow_destroy: true
end
