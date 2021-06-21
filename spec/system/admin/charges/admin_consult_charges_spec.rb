require 'rails_helper'

context 'Admin manages charges on the platform' do
  describe 'Admin view a companies charges' do
    it 'successfully' do
      company = Company.create!(corporate_name: 'CodePlay S.A',
                                cnpj: '55477618000139',
                                billing_address: 'Passagem Morumbi',
                                billing_email: 'faturamento@codeplay.com.br',
                                token: SecureRandom.base58(20))

      product = Product.create!(name: 'Ruby', price: 450, bank_slip_discount: 4,
                                credit_card_discount: 5, pix_discount: 6,
                                token: SecureRandom.base58(20), company: company)

      payment_method = PaymentMethod.create!(name: 'Boleto Banco Laranja',
                                             tax: 8, max_tax: 15,
                                             status: true, form_of_payment: 1)

      bank_slip = BankSlip.create!(bank_number: '341', agency_number: '1690',
                                   account_number: '6557827',
                                   payment_method: payment_method, company: company)

      final_client = FinalClient.create!(name: 'João Silva', cpf: '12345678910',
                                         token: SecureRandom.base58(20))

      Charge.create!(original_value: 450, discounted_amount: 432, token: SecureRandom.base58(20),
                     status: :pending, payment_method: payment_method, company: company,
                     final_client: final_client, product: product, bank_slip: bank_slip)

      login_admin
      visit root_path
      click_on 'Empresas'
      click_on 'CodePlay S.A'
      click_on 'Consultar Cobranças'

      expect(current_path).to eq(admin_company_charges_path(company))
      expect(page).to have_content('Ruby')
      expect(page).to have_content('Boleto')
      expect(page).to have_content('R$ 450,00')
      expect(page).to have_content('Pendente')

    end

    it 'and view details of a charge' do
      company = Company.create!(corporate_name: 'CodePlay S.A',
                                cnpj: '55477618000139',
                                billing_address: 'Passagem Morumbi',
                                billing_email: 'faturamento@codeplay.com.br',
                                token: SecureRandom.base58(20))

      product = Product.create!(name: 'Ruby', price: 450, bank_slip_discount: 4,
                                credit_card_discount: 5, pix_discount: 6,
                                token: SecureRandom.base58(20), company: company)

      payment_method = PaymentMethod.create!(name: 'Boleto Banco Laranja',
                                             tax: 8, max_tax: 15,
                                             status: true, form_of_payment: 1)

      bank_slip = BankSlip.create!(bank_number: '341', agency_number: '1690',
                                   account_number: '6557827',
                                   payment_method: payment_method, company: company)

      final_client = FinalClient.create!(name: 'João Silva', cpf: '12345678910',
                                         token: SecureRandom.base58(20))

      charge = Charge.create!(original_value: 450, discounted_amount: 432, token: SecureRandom.base58(20),
                              status: :pending, payment_method: payment_method, company: company,
                              final_client: final_client, product: product, bank_slip: bank_slip)

      login_admin
      visit admin_company_charges_path(company)
      click_on 'Ruby'

      expect(current_path).to eq(admin_company_charge_path(company, charge))
      expect(page).to have_content('Ruby')
      expect(page).to have_content('R$ 450')
      expect(page).to have_content('R$ 432')
      expect(page).to have_content('Boleto')
      expect(page).to have_content('João Silva')
      expect(page).to have_content('12345678910')
      expect(page).to have_content(I18n.l(charge.created_at, format: :short))

    end

    it 'no charges available' do
      company = Company.create!(corporate_name: 'CodePlay S.A',
                                cnpj: '55477618000139',
                                billing_address: 'Passagem Morumbi',
                                billing_email: 'faturamento@codeplay.com.br',
                                token: SecureRandom.base58(20))

      login_admin
      visit admin_company_charges_path(company)
    
      expect(page).to have_content('Nenhuma cobrança disponível no momento')

    end
  end
end