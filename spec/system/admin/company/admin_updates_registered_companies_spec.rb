require 'rails_helper'

describe 'Admin updates registered companies on the plataform' do
  it 'successfully' do
    company = Company.create!(corporate_name: 'CoPlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'PassagemMorumbi',
                              billing_email: 'faturamento@codplay.com.br',
                              token: SecureRandom.base58(20))
    login_admin
    visit admin_company_path(company)
    click_on 'Editar'

    fill_in 'CNPJ', with: '00001111222233'
    fill_in 'Razão Social', with: 'CodePlay S.A'
    fill_in 'Endereço de Faturamento', with: 'Passagem Morumbi'
    fill_in 'Email para Faturamento', with: 'faturamento@codeplay.com.br'
    click_on 'Atualizar'

    expect(current_path).to eq(admin_company_path(company))
    expect(page).to have_content('CodePlay S.A')
    expect(page).to have_content('00001111222233')
    expect(page).to have_content('Passagem Morumbi')
    expect(page).to have_content('faturamento@codeplay.com.br')
    expect(page).to have_content('Atualizado com sucesso')

  end
end