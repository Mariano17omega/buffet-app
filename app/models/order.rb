class Order < ApplicationRecord
  belongs_to :user_client
  belongs_to :event

  enum status: { awaiting_evaluation: 0, confirmed_buffet: 5, confirmed_client: 9, canceled: 14 }

  before_validation :generate_code, on: :create
  validates :code, uniqueness: true
  validates :date_event,:num_guests, :details, presence: true, on: :create

  validate  :date_event_is_future

  validates :expiration_date, :extra_fee_discount, :extra_fee_discount_description, :payment_method_used, presence: true, on: :update

  validate  :expiration_date_is_future, on: :update

  private
  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def date_event_is_future
    if self.date_event.present? && self.date_event < Date.today
      self.errors.add(:date_event, 'deve ser futura.')
    elsif self.date_event.blank?
      self.errors.add(:date_event, 'não deve ser vazia.')
    end
  end

  def expiration_date_is_future
    if self.expiration_date.present? && self.expiration_date < Date.today
      self.errors.add(:date_event, 'deve ser futura.')
    elsif self.expiration_date.blank?
      self.errors.add(:date_event, 'não deve ser vazia.')
    end
  end

end
