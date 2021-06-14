class Pix < ApplicationRecord
  belongs_to :payment_method
  belongs_to :company

  validates :bank_number, :pix_key, presence: true
  validates :pix_key, uniqueness: true
  validates_length_of :bank_number, is: 3
  validates_length_of :pix_key, is: 20
end
