require 'rails_helper'

describe 'Admin view registered companies' do
  it 'successfully' do
    Company.create!(corporate_name: 'CodePlay S.A',
                    cnpj: '55477618000139',
                    billing_address: 'Passagem Morumbi',
                    billing_email: 'faturamento@codeplay.com.br',
                    token: SecureRandom.base58(20))

    Company.create!(corporate_name: 'CodeSaga S.A',
                    cnpj: '3820188000139',
                    billing_address: 'Alameda Santos',
                    billing_email: 'faturamento@codesaga.com.br',
                    token: SecureRandom.base58(20))

    login_admin
    visit root_path
    click_on 'Empresas'

    expect(page).to have_content('Lista de Empresas')
    expect(page).to have_link('CodePlay S.A')
    expect(page).to have_link('CodeSaga S.A')
    expect(page).to have_text('55477618000139')
    expect(page).to have_text('3820188000139')

  end

  it 'and view details' do
    company = Company.create!(corporate_name: 'CodePlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'Passagem Morumbi',
                              billing_email: 'faturamento@codeplay.com.br',
                              token: SecureRandom.base58(20))
    login_admin
    visit admin_companies_path
    click_on 'CodePlay S.A'

    expect(current_path).to eq(admin_company_path(company))
    expect(page).to have_content('CodePlay S.A')
    expect(page).to have_content('55477618000139')
    expect(page).to have_content('Passagem Morumbi')
    expect(page).to have_content('faturamento@codeplay.com.br')
    expect(page).to have_content(company.token)
    expect(page).to have_link('Voltar', href: admin_companies_path)

  end
end