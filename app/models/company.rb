class Company < ApplicationRecord
  before_create :token_generate

  validates :corporate_name, :cnpj, :billing_address, :billing_email, presence: true
  validates :billing_email, :cnpj, uniqueness: true
  validates :cnpj, numericality: { greater_than_or_equal_to: 0 }
  validates_length_of :cnpj, is: 14

  has_many :users
  has_many :bank_slips
  has_many :credit_cards
  has_many :pixes
  has_many :products
  has_many :final_client_companies
  has_many :final_clients, through: :final_client_companies

  private

  def token_generate
    self.token = SecureRandom.base58(20)
  end
end
