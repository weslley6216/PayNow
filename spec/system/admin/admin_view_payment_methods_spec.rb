require 'rails_helper'

describe 'and view the payment methods' do
  it 'successfully' do
    PaymentMethod.create!(name: 'Boleto Banco Laranja',
                          tax: 8, max_tax: 15,
                          status: true, form_of_payment: 1)

    PaymentMethod.create!(name: 'Cartão de Crédito Roxinho',
                          tax: 12, max_tax: 20,
                          status: false, form_of_payment: 2)

    login_admin
    visit root_path
    click_on 'Meios de Pagamentos'

    expect(page).to have_content('Meios de Pagamentos')
    expect(page).to have_content('Boleto Banco Laranja')
    expect(page).to have_content('Ativo')
    expect(page).to have_content('Cartão de Crédito Roxinho')
    expect(page).to have_content('Inativo')
    expect(page).to have_link('Voltar', href: root_path)

  end

  it 'and view details' do
    PaymentMethod.create!(name: 'Boleto Banco Laranja',
                          tax: 8, max_tax: 15,
                          status: true, form_of_payment: 1)

    PaymentMethod.create!(name: 'Cartão de Crédito Roxinho',
                          tax: 12, max_tax: 20,
                          status: false, form_of_payment: 2)

    login_admin
    visit admin_payment_methods_path
    click_on 'Boleto Banco Laranja'

    expect(page).to have_content('Boleto Banco Laranja')
    expect(page).to have_content('8,0 %')
    expect(page).to have_content('R$ 15,00')
    expect(page).to have_content('Ativo')
    expect(page).to have_link('Voltar', href: admin_payment_methods_path)
  end

  it 'no payment method available' do

    login_admin
    visit admin_payment_methods_path

    expect(page).to have_content('Nenhum meio de pagamento disponível')
  end
end