require 'rails_helper'

describe 'User view the payment methods contracted by the company' do
  it 'bank slip sucessfully' do
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
    click_on 'Minha Empresa'

    expect(page).to have_content('Meios de Pagamentos Contratados')
    expect(page).to have_content('341')
    expect(page).to have_content('1690')
    expect(page).to have_content('6557827')
  end

  it 'credit card successfully' do
    credit_card = PaymentMethod.create!(name: 'Cartão de Crédito MestreCard',
                                        tax: 12, max_tax: 20,
                                        status: true, form_of_payment: 2)

    company = Company.create!(corporate_name: 'CodeSaga S.A',
                              cnpj: '32107618000139',
                              billing_address: 'Alameda Santos',
                              billing_email: 'faturamento@codesaga.com.br',
                              token: SecureRandom.base58(20))

    company_user = User.create!(email: 'user@codeplay.com.br',
                                password: '123456', company: company)

    CreditCard.create!(credit_code: 'meRT648dV545t24591ZU',
                       payment_method: credit_card, company: company)

    login_as company_user, scope: :user
    visit root_path
    click_on 'Minha Empresa'

    expect(page).to have_content('meRT648dV545t24591ZU')
  end

  it 'pix successfully' do
    pix = PaymentMethod.create!(name: 'Pix Banco Roxinho',
                                tax: 4, max_tax: 129.90,
                                status: true, form_of_payment: 3)

    company = Company.create!(corporate_name: 'CodeSaga S.A',
                              cnpj: '32107618000139',
                              billing_address: 'Alameda Santos',
                              billing_email: 'faturamento@codesaga.com.br',
                              token: SecureRandom.base58(20))

    company_user = User.create!(email: 'user@codeplay.com.br',
                                password: '123456', company: company)

    Pix.create!(bank_number: '001', pix_key: 'a46Hu7dV545t24591ZU1',
                payment_method: pix, company: company)

    login_as company_user, scope: :user
    visit root_path
    click_on 'Minha Empresa'

    expect(page).to have_content('a46Hu7dV545t24591ZU')
  end

  it 'no payment method contracted' do

    login_company_user
    visit root_path
    click_on 'Minha Empresa'

    expect(page).to have_content('Nenhum método de pagamento contratado')
  end

  it 'cannot see contracted payment methods if you are not logged in' do
    company = Company.create!(corporate_name: 'CodeSaga S.A',
                              cnpj: '32107618000139',
                              billing_address: 'Alameda Santos',
                              billing_email: 'faturamento@codesaga.com.br',
                              token: SecureRandom.base58(20))

    visit user_company_path(company.token)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end
end
