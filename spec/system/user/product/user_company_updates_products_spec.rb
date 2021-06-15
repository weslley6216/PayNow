require 'rails_helper'

describe 'company user updates a product' do
  it 'succesfully' do
    company = Company.create!(corporate_name: 'CodePlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'Passagem Morumbi',
                              billing_email: 'faturamento@codeplay.com.br',
                              token: SecureRandom.base58(20))

    Product.create!(name: 'Ruby', price: 450, bank_slip_discount: 4,
                    credit_card_discount: 5, pix_discount: 6,
                    token: SecureRandom.base58(20), company: company)

    login_company_user
    visit user_company_product_path(company, Product.last)
    click_on 'Editar'

    fill_in 'Nome', with: 'Ruby on Rails'
    fill_in 'Preço', with: 325
    fill_in 'Desconto Boleto', with: 7
    fill_in 'Desconto Cartão de Crédito', with: 8
    fill_in 'Desconto Pix', with: 9
    click_on 'Atualizar'

    expect(current_path).to eq(user_company_product_path(company, Product.last))
    expect(page).to have_content('Produto atualizado com sucesso')
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('R$ 325,00')
    expect(page).to have_content('7%')
    expect(page).to have_content('8%')
    expect(page).to have_content('9%')
    expect(page).to have_content(Product.last.token)
  end

  it 'must be looged in to update product' do
    company = Company.create!(corporate_name: 'CodePlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'Passagem Morumbi',
                              billing_email: 'faturamento@codeplay.com.br',
                              token: SecureRandom.base58(20))

    Product.create!(name: 'Ruby', price: 450, bank_slip_discount: 4,
                    credit_card_discount: 5, pix_discount: 6,
                    token: SecureRandom.base58(20), company: company)

    visit user_company_products_path(company)
    expect(current_path).to eq(new_user_session_path)
  end
end