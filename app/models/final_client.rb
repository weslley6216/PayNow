class FinalClient < ApplicationRecord
  before_create :token_generate
  
  has_many :final_client_companies
  has_many :companies, through: :final_client_companies

  validates :name, :cpf, presence: true
  validates :cpf, uniqueness: true

  private

  def token_generate
    self.token = SecureRandom.base58(20)
  end

end
