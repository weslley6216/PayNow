class PaymentMethod < ApplicationRecord
  after_create_commit :attach_icon

  has_one_attached :icon

  validates :tax, :max_tax, numericality: { greater_than_or_equal_to: 0 }
  validates :form_of_payment, :name, :tax, :max_tax, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  enum form_of_payment: { bank_slip: 1, credit_card: 2, pix: 3 }

  scope :available, -> { where(status: true) }

  private

  def attach_icon
    return if icon.attached?

    if PaymentMethod.last.bank_slip?
      icon.attach(io: File.open(Rails.root.join('app/assets/images/bank_slip.png')),
                  filename: 'bank_slip.png')
    elsif PaymentMethod.last.credit_card?
      icon.attach(io: File.open(Rails.root.join('app/assets/images/credit_card.jpg')),
                  filename: 'credit_card.jpg')
    elsif PaymentMethod.last.pix?
      icon.attach(io: File.open(Rails.root.join('app/assets/images/pix.png')),
                  filename: 'pix.png')
    end
    
  end
end
