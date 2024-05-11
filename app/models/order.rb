class Order < ApplicationRecord
  belongs_to :user_client
  belongs_to :event
  enum status: { awaiting_evaluation: 0, confirmed: 5, canceled: 9 }

  before_validation :generate_code, on: :create

  validates :code, uniqueness: true
  validate :date_event_is_future

  private
  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def date_event_is_future
    if self.date_event < Date.today
      self.errors.add(:date_event, 'deve ser futura.')
    end

  end
end
