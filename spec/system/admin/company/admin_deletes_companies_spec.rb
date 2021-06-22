require 'rails_helper'

describe 'Admin deletes companies of the plataform' do
  it 'successfully' do
    company = Company.create!(corporate_name: 'CodePlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'Passagem Morumbi',
                              billing_email: 'faturamento@codeplay.com.br',
                              token: SecureRandom.base58(20))

    login_admin
    visit admin_company_path(company.token)
    expect { click_on 'Apagar' }.to change { Company.count }.by(-1)

    expect(page).to have_text('Empresa removida com sucesso')
    expect(current_path).to eq(admin_companies_path)

  end

  it 'must be logged in to delete a registered company' do
    company = Company.create!(corporate_name: 'CodePlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'Passagem Morumbi',
                              billing_email: 'faturamento@codeplay.com.br',
                              token: SecureRandom.base58(20))

    visit admin_company_path(company.token)

    expect(current_path).to eq(new_admin_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end
end