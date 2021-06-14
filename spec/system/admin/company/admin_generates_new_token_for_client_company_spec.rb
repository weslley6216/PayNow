require 'rails_helper'

describe 'Admin generates a new token for client company' do
  it 'successfully' do
    company = Company.create!(corporate_name: 'CoPlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'PassagemMorumbi',
                              billing_email: 'faturamento@codplay.com.br',
                              token: SecureRandom.base58(20))

    current_token = company.token

    login_admin
    visit admin_company_path(company)
    click_on 'Gerar novo token'

    expect(current_token).to_not eq(Company.last.token)
  end
end
