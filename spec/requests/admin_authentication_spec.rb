require 'rails_helper'

describe 'Admin authetication' do
  it 'must be logged in to generate a new token' do

    company = Company.create!(corporate_name: 'CodePlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'Passagem Morumbi',
                              billing_email: 'faturamento@codeplay.com.br',
                              token: SecureRandom.base58(20))

    put regenerate_token_admin_company_path(company)

    expect(response).to redirect_to(new_admin_session_path)

  end
end
