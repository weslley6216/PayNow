require 'rails_helper'

describe 'user of a company view the created products' do
  it 'succesfully' do
    company = Company.create!(corporate_name: 'CodePlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'Passagem Morumbi',
                              billing_email: 'faturamento@codeplay.com.br',
                              token: SecureRandom.base58(20))

    Product.create!(name: 'Ruby', price: 450, bank_slip_discount: 4,
                    credit_card_discount: 5, pix_discount: 6,
                    token: SecureRandom.base58(20), company: company)

    Product.create!(name: 'Ruby on Rails', price: 45, bank_slip_discount: 7,
                    credit_card_discount: 8, pix_discount: 9,
                    token: SecureRandom.base58(20), company: company)

    company_user = User.create!(email: 'user@codeplay.com.br',
                                password: '123456', company: company)

    login_as company_user, scope: :user
    visit root_path
    click_on 'Meus Produtos'

    expect(page).to have_link('Ruby')
    expect(page).to have_link('Ruby on Rails')

  end

  it 'and view details and go back to the previous page' do
    company = Company.create!(corporate_name: 'CodePlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'Passagem Morumbi',
                              billing_email: 'faturamento@codeplay.com.br',
                              token: SecureRandom.base58(20))

    Product.create!(name: 'Ruby', price: 45, bank_slip_discount: 4,
                    credit_card_discount: 5, pix_discount: 6,
                    token: SecureRandom.base58(20), company: company)

    Product.create!(name: 'Ruby on Rails', price: 450, bank_slip_discount: 7,
                    credit_card_discount: 8, pix_discount: 9,
                    token: SecureRandom.base58(20), company: company)

    company_user = User.create!(email: 'user@codeplay.com.br',
                                password: '123456', company: company)

    login_as company_user, scope: :user
    visit user_company_products_path(company)
    click_on 'Ruby on Rails'
 
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('R$ 450,00')
    expect(page).to have_content('7%')
    expect(page).to have_content('8%')
    expect(page).to have_content('9%')
    expect(page).to have_content(Product.last.token)
    expect(page).to have_link('Voltar', href: user_company_products_path(company))
  end

  it 'and no products is available' do
    company = Company.create!(corporate_name: 'CodeSaga S.A',
                              cnpj: '38201880001939',
                              billing_address: 'Alameda Santos',
                              billing_email: 'faturamento@codesaga.com.br',
                              token: SecureRandom.base58(20))

    login_company_user
    visit user_company_products_path(company)

    expect(page).to have_content('Nenhum produto disponível')
  end

end