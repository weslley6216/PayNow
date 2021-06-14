class BankSlip < ApplicationRecord
  belongs_to :payment_method
  belongs_to :company

  validates :bank_number, :agency_number, :account_number, presence: true
  validates :account_number, uniqueness: true
  validates :bank_number, :agency_number, :account_number, numericality: { greater_than_or_equal_to: 0 }
  validates_length_of :bank_number, is: 3
  validates_length_of :agency_number, is: 4
  validates_length_of :account_number, minimum: 5, maximum: 8
end
