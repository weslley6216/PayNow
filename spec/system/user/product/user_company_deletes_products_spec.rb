require 'rails_helper'

describe 'user deletes a products' do
  it 'successfully' do
    company = Company.create!(corporate_name: 'CodePlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'Passagem Morumbi',
                              billing_email: 'faturamento@codeplay.com.br',
                              token: SecureRandom.base58(20))

    Product.create!(name: 'Ruby', price: 450, bank_slip_discount: 4,
                    credit_card_discount: 5, pix_discount: 6,
                    token: SecureRandom.base58(20), company: company)

    login_company_user
    visit user_company_product_path(company.token, Product.last)

    expect { click_link 'Apagar' }.to change { Product.count }.by(-1)
    expect(page).to have_content('Produto removido com sucesso')
    expect(current_path).to eq(user_company_products_path(company.token))
  end
end
