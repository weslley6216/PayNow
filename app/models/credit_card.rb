class CreditCard < ApplicationRecord
  belongs_to :payment_method
  belongs_to :company

  validates :credit_code, presence: true
  validates :credit_code, uniqueness: true
  validates_length_of :credit_code, is: 20
end
