class Company < ApplicationRecord
  validates :corporate_name, :cnpj, :billing_address, :billing_email, presence: true
  validates :billing_email, :cnpj, uniqueness: true
end
