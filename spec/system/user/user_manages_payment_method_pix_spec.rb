require 'rails_helper'

describe 'Logged in user contracts a form of payment of the pix type' do
  it 'successfully' do
    PaymentMethod.create!(name: 'Pix Banco Roxinho',
                          tax: 4, max_tax: 129.90,
                          status: true, form_of_payment: 3)

    company = Company.create!(corporate_name: 'CodeSaga S.A',
                              cnpj: '32107618000139',
                              billing_address: 'Alameda Santos',
                              billing_email: 'faturamento@codesaga.com.br',
                              token: SecureRandom.base58(20))

    company_user = User.create!(email: 'user@codeplay.com.br',
                                password: '123456', company: company)

    login_as company_user, scope: :user
    visit root_path

    click_on 'Meios de Pagamentos Disponíveis'
    click_on 'Pix Banco Roxinho'
    click_on 'Contratar Meio de Pagamento'

    fill_in 'Número do Banco', with: '001'
    fill_in 'Chave Pix', with: 'a46Hu7dV545t24591ZU1'
    click_on 'Cadastrar'

    expect(page).to have_content('Dados Pix')
    expect(page).to have_content('a46Hu7dV545t24591ZU1')
    expect(page).to have_content('Dados Cadastrados com Sucesso')
    expect(page).to have_link('Voltar', href: user_payment_methods_path)
  end

  it 'and attributes cannot be blank' do
    pix = PaymentMethod.create!(name: 'Pix Banco Roxinho',
                                tax: 4, max_tax: 129.90,
                                status: true, form_of_payment: 3)

    company = Company.create!(corporate_name: 'CodeSaga S.A',
                              cnpj: '32107618000139',
                              billing_address: 'Alameda Santos',
                              billing_email: 'faturamento@codesaga.com.br',
                              token: SecureRandom.base58(20))

    company_user = User.create!(email: 'user@codeplay.com.br',
                                password: '123456', company: company)

    Pix.create!(bank_number: '001', pix_key: 'a46Hu7dV545t24591ZU1',
                payment_method: pix, company: company)

    login_as company_user, scope: :user
    visit new_user_payment_method_pix_path(pix)

    fill_in 'Número do Banco', with: ''
    fill_in 'Chave Pix', with: ''
    click_on 'Cadastrar'
    save_page
    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'pix key must be unique' do
    pix = PaymentMethod.create!(name: 'Pix Banco Roxinho',
                                tax: 4, max_tax: 129.90,
                                status: true, form_of_payment: 3)

    company = Company.create!(corporate_name: 'CodeSaga S.A',
                              cnpj: '32107618000139',
                              billing_address: 'Alameda Santos',
                              billing_email: 'faturamento@codesaga.com.br',
                              token: SecureRandom.base58(20))

    company_user = User.create!(email: 'user@codeplay.com.br',
                                password: '123456', company: company)

    Pix.create!(bank_number: '001', pix_key: 'a46Hu7dV545t24591ZU1',
                payment_method: pix, company: company)


    login_as company_user, scope: :user
    visit new_user_payment_method_pix_path(pix)

    fill_in 'Número do Banco', with: '001'
    fill_in 'Chave Pix', with: 'a46Hu7dV545t24591ZU1'
    click_on 'Cadastrar'

    expect(page).to have_content('já está em uso')
  end

  it 'must be logged in to hire a pix payment method' do
    pix = PaymentMethod.create!(name: 'Pix Banco Roxinho',
                                tax: 4, max_tax: 129.90,
                                status: true, form_of_payment: 3)

    visit new_user_payment_method_pix_path(pix)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end
end