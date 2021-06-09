class PaymentMethod < ApplicationRecord
  after_create_commit :attach_icon

  has_one_attached :icon

  enum form_of_payment: { bank_slip: 1, credit_card: 2, pix: 3 }

  private

  def attach_icon
    return if icon.attached?

    if PaymentMethod.last.bank_slip?
      icon.attach(io: File.open(Rails.root.join('app/assets/images/bank_slip.png')),
                  filename: 'pix.png')
    elsif PaymentMethod.last.credit_card?
      icon.attach(io: File.open(Rails.root.join('app/assets/images/credit_card.jpg')),
                  filename: 'pix.png')
    elsif PaymentMethod.last.pix?
      icon.attach(io: File.open(Rails.root.join('app/assets/images/pix.png')),
                  filename: 'pix.png')
    end
  end
end
