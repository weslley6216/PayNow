class BankSlip < ApplicationRecord
  belongs_to :payment_method
  belongs_to :company

  validates :bank_number, :agency_number, :account_number, presence: true
end
