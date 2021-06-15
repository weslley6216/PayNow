require 'rails_helper'

describe 'company user registers a product' do
  it 'succesfully' do
    company = Company.create!(corporate_name: 'CodePlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'Passagem Morumbi',
                              billing_email: 'faturamento@codeplay.com.br',
                              token: SecureRandom.base58(20))

    login_company_user
    visit user_company_products_path(company)
    click_on 'Criar Produto'

    fill_in 'Nome', with: 'Ruby on Rails'
    fill_in 'Preço', with: 450
    fill_in 'Desconto Boleto', with: 4
    fill_in 'Desconto Cartão de Crédito', with: 5
    fill_in 'Desconto Pix', with: 6
    click_on 'Cadastrar'

    expect(current_path).to eq(user_company_product_path(company, Product.last))
    expect(page).to have_content('Produto criado com sucesso')
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('R$ 450,00')
    expect(page).to have_content('4%')
    expect(page).to have_content('5%')
    expect(page).to have_content('6%')
  end

  it 'name and price attributes cannot be blank' do
    company = Company.create!(corporate_name: 'CodePlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'Passagem Morumbi',
                              billing_email: 'faturamento@codeplay.com.br',
                              token: SecureRandom.base58(20))
    login_company_user
    visit user_company_products_path(company)
    click_on 'Criar Produto'

    fill_in 'Nome', with: ''
    fill_in 'Preço', with: ''
    fill_in 'Desconto Boleto', with: ''
    fill_in 'Desconto Cartão de Crédito', with: ''
    fill_in 'Desconto Pix', with: ''
    click_on 'Cadastrar'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and name must be unique' do
    company = Company.create!(corporate_name: 'CodePlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'Passagem Morumbi',
                              billing_email: 'faturamento@codeplay.com.br',
                              token: SecureRandom.base58(20))

    Product.create!(name: 'Ruby', price: 450, bank_slip_discount: 4,
                    credit_card_discount: 5, pix_discount: 6, company: company)

    login_company_user
    visit user_company_products_path(company)
    click_on 'Criar Produto'

    fill_in 'Nome', with: 'Ruby'
    click_on 'Cadastrar'

    expect(page).to have_content('já está em uso')

  end
end
