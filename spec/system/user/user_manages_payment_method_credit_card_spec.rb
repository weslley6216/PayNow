require 'rails_helper'

describe 'Logged in user contracts a form of payment of the credit card type' do
  it 'successfully' do
    PaymentMethod.create!(name: 'Cartão de Crédito MestreCard',
                          tax: 12, max_tax: 20,
                          status: true, form_of_payment: 2)

    company = Company.create!(corporate_name: 'CodeSaga S.A',
                              cnpj: '32107618000139',
                              billing_address: 'Alameda Santos',
                              billing_email: 'faturamento@codesaga.com.br',
                              token: SecureRandom.base58(20))

    company_user = User.create!(email: 'user@codeplay.com.br',
                                password: '123456', company: company)

    login_as company_user, scope: :user
    visit root_path

    click_on 'Meios de Pagamentos Disponíveis'
    click_on 'Cartão de Crédito MestreCard'
    click_on 'Contratar Meio de Pagamento'

    fill_in 'Código Operadora do Cartão', with: 'meRT648dV545t24591ZU'
    click_on 'Cadastrar'

    expect(page).to have_content('Dados Cartão de Crédito')
    expect(page).to have_content('meRT648dV545t24591ZU')
    expect(page).to have_content('Dados Cadastrados com Sucesso')
    expect(page).to have_link('Voltar', href: user_payment_methods_path)
  end

  it 'and attributes cannot be blank' do
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
    visit new_user_payment_method_credit_card_path(credit_card)

    fill_in 'Código Operadora do Cartão', with: ''
    click_on 'Cadastrar'

    expect(page).to have_content('não pode ficar em branco')
  end

  it 'credit code must be unique' do
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
    visit new_user_payment_method_credit_card_path(credit_card)

    fill_in 'Código Operadora do Cartão', with: 'meRT648dV545t24591ZU'
    click_on 'Cadastrar'

    expect(page).to have_content('já está em uso')
  end
end