require 'rails_helper'

describe 'Admin deletes payment method' do
  it 'successfully' do
    boleto = PaymentMethod.create!(name: 'Boleto Bancário',
                                   tax: 8, max_tax: 15,
                                   status: true, form_of_payment: 1)
    login_admin
    visit admin_payment_method_path(boleto)
    expect { click_on 'Apagar' }.to change { PaymentMethod.count }.by(-1)

    expect(page).to have_text('removido com sucesso')
    expect(current_path).to eq(admin_payment_methods_path)
  end

  it 'must be logged in to delete a payment method' do
    boleto = PaymentMethod.create!(name: 'Boleto Bancário',
                                   tax: 8, max_tax: 15,
                                   status: true, form_of_payment: 1)

    visit admin_payment_method_path(boleto)

    expect(current_path).to eq(new_admin_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end
end