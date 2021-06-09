class AddFormOfPaymentToPaymentMethod < ActiveRecord::Migration[6.1]
  def change
    add_column :payment_methods, :form_of_payment, :integer, null: false
  end
end
