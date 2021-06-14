require 'rails_helper'

describe 'Logged in user contracts a form of payment of the bank slip type' do
  it 'successfully' do
    boleto = PaymentMethod.create!(name: 'Boleto Banco Laranja',
                                   tax: 8, max_tax: 15,
                                   status: true, form_of_payment: 1)

    company = Company.create!(corporate_name: 'CodePlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'Passagem Morumbi',
                              billing_email: 'faturamento@codeplay.com.br',
                              token: SecureRandom.base58(20))

    company_user = User.create!(email: 'user@codeplay.com.br',
                                password: '123456', company: company)

    BankSlip.create!(bank_number: '341', agency_number: '1690', account_number: '6557827',
                     payment_method: boleto, company: company)

    login_as company_user, scope: :user
    visit root_path

    click_on 'Meios de Pagamentos Disponíveis'
    click_on 'Boleto Banco Laranja'
    click_on 'Contratar Meio de Pagamento'

    fill_in 'Código do Banco', with: '341'
    fill_in 'Número da Agência', with: '1690'
    fill_in 'Número da Conta', with: '7878963'
    click_on 'Cadastrar'

    expect(page).to have_content('Dados Boleto Bancário')
    expect(page).to have_content('341')
    expect(page).to have_content('1690')
    expect(page).to have_content('7878963')
    expect(page).to have_content('Dados Cadastrados com Sucesso')
    expect(page).to have_link('Voltar', href: user_payment_methods_path)
  end

  it 'and attributes cannot be blank' do
    boleto = PaymentMethod.create!(name: 'Boleto Banco Laranja',
                                   tax: 8, max_tax: 15,
                                   status: true, form_of_payment: 1)

    company = Company.create!(corporate_name: 'CodePlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'Passagem Morumbi',
                              billing_email: 'faturamento@codeplay.com.br',
                              token: SecureRandom.base58(20))

    company_user = User.create!(email: 'user@codeplay.com.br',
                                password: '123456', company: company)

    BankSlip.create!(bank_number: '341', agency_number: '1690', account_number: '6557827',
                     payment_method: boleto, company: company)

    login_as company_user, scope: :user
    visit new_user_payment_method_bank_slip_path(boleto)

    fill_in 'Código do Banco', with: ''
    fill_in 'Número da Agência', with: ''
    fill_in 'Número da Conta', with: ''
    click_on 'Cadastrar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end
end