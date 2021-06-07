require 'rails_helper'

describe 'Admin updates payment method' do
  it 'sucessfully' do
    boleto = PaymentMethod.create!(name: 'Boleto Bancário',
                                   tax: 8, max_tax: 15, status: true)
    
    login_admin
    visit admin_payment_method_path(boleto)
    click_on 'Editar'

    fill_in 'Nome', with: 'Boleto'
    fill_in 'Taxa por Cobrança em (%)', with: 3
    fill_in 'Taxa Máxima em (R$)', with: 9
    click_on 'Atualizar'

    expect(page).to have_content('Boleto')
    expect(page).to have_content('3')
    expect(page).to have_content('9')
    expect(page).to have_content('Meio de Pagamento atualizado com sucesso')
    end

  it 'must be logged in to update a payment method' do
    boleto = PaymentMethod.create!(name: 'Boleto Bancário',
                                   tax: 8, max_tax: 15, status: true)
                                    
    visit admin_payment_method_path(boleto)

    expect(current_path).to eq(new_admin_session_path)
  end
end