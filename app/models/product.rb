class Product < ApplicationRecord
  belongs_to :company
  before_create :token_generate

  validates :name, :price, presence: true
  validates :name, uniqueness: true

  private

  def token_generate
    self.token = SecureRandom.base58(20)
  end
  
end
