require 'rails_helper'

describe 'Admin updates payment method' do
  it 'sucessfully' do
    credit_card = PaymentMethod.create!(name: 'PISA',
                                        tax: 8, max_tax: 15,
                                        status: false, form_of_payment: 2)
    login_admin
    visit admin_payment_method_path(credit_card)
    click_on 'Editar'

    fill_in 'Nome', with: 'MestreCard'
    fill_in 'Taxa por Cobrança em (%)', with: 3.5
    fill_in 'Taxa Máxima em (R$)', with: 9.8
    click_on 'Atualizar'

    expect(page).to have_content('MestreCard')
    expect(page).to have_content('3,5')
    expect(page).to have_content('9,8')
    expect(page).to have_content('Ativo')
    expect(page).to have_content('Meio de Pagamento atualizado com sucesso')
  end

  it 'must be logged in to update a payment method' do
    boleto = PaymentMethod.create!(name: 'Boleto Banco Roxinho',
                                   tax: 8, max_tax: 15,
                                   status: true, form_of_payment: 1)

    visit admin_payment_method_path(boleto)

    expect(current_path).to eq(new_admin_session_path)
  end
end