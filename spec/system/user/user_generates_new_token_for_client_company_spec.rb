require 'rails_helper'

describe 'User generates a new token for company' do
  it 'successfully' do
    company = Company.create!(corporate_name: 'CodeSaga S.A',
                              cnpj: '32107618000139',
                              billing_address: 'Alameda Santos',
                              billing_email: 'faturamento@codesaga.com.br',
                              token: SecureRandom.base58(20))

    current_token = company.token

    login_company_user
    visit user_company_path(company)
    click_on 'Gerar novo token'

    expect(current_token).to_not eq(Company.last.token)
    expect(page).to have_content('Novo token gerado com sucesso')
  end
end
