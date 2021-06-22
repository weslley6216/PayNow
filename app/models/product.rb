class Product < ApplicationRecord
  belongs_to :company
  before_create :token_generate

  validates :name, :price, presence: true
  validates :name, uniqueness: true
  validates :price, :bank_slip_discount, :credit_card_discount,
            :pix_discount, numericality: { greater_than_or_equal_to: 0 }

  private

  def token_generate
    self.token = SecureRandom.base58(20)
  end
  
end
