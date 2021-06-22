class Charge < ApplicationRecord
  before_create :token_generate

  belongs_to :payment_method
  belongs_to :bank_slip, optional: true
  belongs_to :credit_card, optional: true
  belongs_to :pix, optional: true
  belongs_to :company
  belongs_to :final_client
  belongs_to :product

  validates :original_value, :discounted_amount, :status, presence: true
  enum status: { pending: 1, approved: 2 }

  def token_generate
    self.token = SecureRandom.base58(20)
  end
end
