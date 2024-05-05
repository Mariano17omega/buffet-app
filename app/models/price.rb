class Price < ApplicationRecord
  belongs_to :event
  validates  :price_base_weekdays, :price_add_weekdays, :price_overtime_weekdays,
             :price_base_weekend, :price_add_weekend, :price_overtime_weekend , presence: true

end
