class PaymentMethod < ApplicationRecord

  has_one_attached :icone

  validates :name, :tax, :max_tax, presence: true
  validates :name, uniqueness: true
end
