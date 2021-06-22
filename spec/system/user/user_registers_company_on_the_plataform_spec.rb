require 'rails_helper'

describe 'Authenticated user registers your company' do
  it 'successfully' do

    login_user
    visit root_path
    click_on 'Cadastre Sua Empresa'

    fill_in 'Razão Social', with: 'CodePlay S.A'
    fill_in 'CNPJ', with: '55477618000139'
    fill_in 'Endereço de Faturamento', with: 'Passagem Morumbi'
    fill_in 'Email para Faturamento', with: 'faturamento@codeplay.com.br'
    click_on 'Cadastrar Empresa'

    expect(page).to have_content('CodePlay S.A')
    expect(page).to have_content('55477618000139')
    expect(page).to have_content('Passagem Morumbi')
    expect(page).to have_content('faturamento@codeplay.com.br')
    expect(page).to have_content('Empresa Cadastrada com Sucesso')
    expect(page).to_not have_content('Cadastre Sua Empresa')
  end

  it 'and attributes cannot be blank' do

    login_user
    visit new_user_company_path

    fill_in 'CNPJ', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'Endereço de Faturamento', with: ''
    fill_in 'Email para Faturamento', with: ''
    click_on 'Cadastrar Empresa'

    expect(page).to have_content('não pode ficar em branco', count: 4)
  end

  it 'cnpj and billing address must be unique' do
    Company.create!(cnpj: '55477618000139',
                    corporate_name: 'CodePlay S.A',
                    billing_address: 'Passagem Morumbi',
                    billing_email: 'faturamento@codeplay.com.br',
                    token: SecureRandom.base58(20))

    login_user
    visit new_user_company_path

    fill_in 'CNPJ', with: '55477618000139'
    fill_in 'Email para Faturamento', with: 'faturamento@codeplay.com.br'
    click_on 'Cadastrar Empresa'

    expect(page).to have_content('já está em uso', count: 2)

  end

  it 'must be logged in to register a company on the platform' do
    visit new_user_company_path

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end
end

