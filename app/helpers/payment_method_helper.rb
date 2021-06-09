module PaymentMethodHelper
  def human_attribute_form_of_payments
    Hash[PaymentMethod.form_of_payments.map { |key, value| [key, PaymentMethod.human_attribute_name("form_of_payment.#{key}")] }]
  end
end
