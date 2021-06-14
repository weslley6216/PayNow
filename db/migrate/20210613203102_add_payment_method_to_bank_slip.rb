class AddPaymentMethodToBankSlip < ActiveRecord::Migration[6.1]
  def change
    add_reference :bank_slips, :payment_method, null: false, foreign_key: true
  end
end
