require 'rails_helper'

describe 'User view payment method contracted by the company ' do
  it 'sucessfully' do
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

    BankSlip.create!(bank_number: '341', agency_number: '1690', account_number: '655782-7',
                     payment_method: boleto, company: company)

    login_as company_user, scope: :user
    visit root_path
    click_on 'Minha Empresa'

    expect(page).to have_content('Meios de Pagamentos Contratados')
    expect(page).to have_content('341')
    expect(page).to have_content('1690')
    expect(page).to have_content('655782-7')
  end

  it 'no payment method contracted' do

    login_company_user
    visit root_path
    click_on 'Minha Empresa'

    expect(page).to have_content('Nenhum método de pagamento contratado')
  end
end
