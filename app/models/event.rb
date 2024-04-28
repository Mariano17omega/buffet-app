class Event < ApplicationRecord
  belongs_to :buffet

  validates :name, :description, :min_guests, :max_guests, :duration, :menu, presence: true
  validates :name, uniqueness: true

end
