require 'rails_helper'

describe 'Admin registers payment methods' do
  it 'succesfully' do
    
    login_admin
    visit root_path
    click_on 'Meios de Pagamento'
    click_on 'Cadastrar Meio de Pagamento'

    select 'Boleto', from: 'Forma de Pagamento'
    fill_in 'Nome', with: 'Boleto Banco Laranja'
    fill_in 'Taxa por Cobrança em (%)', with: 8
    fill_in 'Taxa Máxima em (R$)', with: 15
    click_on 'Criar'

    expect(current_path).to eq(admin_payment_method_path(PaymentMethod.last))
    expect(page).to have_content('Boleto Banco Laranja')
    expect(page).to have_content('8,0 %')
    expect(page).to have_content('R$ 15,00')
    expect(page).to have_link('Voltar', href: admin_payment_methods_path)
    expect(PaymentMethod.last.icon).to be_attached
  end

  it 'and attributes cannot be blank' do

    login_admin
    visit admin_payment_methods_path
    click_on 'Cadastrar Meio de Pagamento'

    select 'Selecione', from: 'Forma de Pagamento'
    fill_in 'Nome', with: ''
    fill_in 'Taxa por Cobrança em (%)', with: ''
    fill_in 'Taxa Máxima em (R$)', with: ''
    click_on 'Criar'

    expect(page).to have_content('não pode ficar em branco', count: 4)
  end

  it 'and name must be unique' do
    PaymentMethod.create!(name: 'Pix Banco Roxinho',
                          tax: 8, max_tax: 15,
                          status: true, form_of_payment: 3)

    login_admin
    visit admin_payment_methods_path
    click_on 'Cadastrar Meio de Pagamento'

    select 'Pix', from: 'Forma de Pagamento'
    fill_in 'Nome', with: 'Pix Banco Roxinho'
    fill_in 'Taxa por Cobrança em (%)', with: 8
    fill_in 'Taxa Máxima em (R$)', with: 15
    click_on 'Criar'

    expect(page).to have_content('já está em uso')
  end

  it 'must be logged in to create a payment method' do
    visit new_admin_payment_method_path

    expect(current_path).to eq(new_admin_session_path)
  end
end
