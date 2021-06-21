require 'rails_helper'

describe 'Charge API' do
  context 'POST /api/v1/charge' do
    it 'must create a bank slip payment method' do

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

      post '/api/v1/charges', params: {

        charge: {

          company_token: company.token,
          product_token: product.token,
          payment_method_id: payment_method.id,
          final_client_token: final_client.token,
          bank_slip_id: bank_slip.id,
          address: 'Colméias, 83',
          district: 'Alvarenga',
          zip_code: '09856-280',
          city: 'São Bernardo do Campo - SP'

        }
      }

      parsed_body = JSON.parse(response.body)
      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['original_value']).to eq('450.0')
      expect(parsed_body['discounted_amount']).to eq('432.0')
      expect(parsed_body['token']).to eq(Charge.last.token.to_s)
      expect(parsed_body['status']).to eq(Charge.last.status.to_s)
      expect(parsed_body['address']).to eq('Colméias, 83')
      expect(parsed_body['district']).to eq('Alvarenga')
      expect(parsed_body['zip_code']).to eq('09856-280')
      expect(parsed_body['city']).to eq('São Bernardo do Campo - SP')
    end

    it 'must create a credit card payment method' do

      company = Company.create!(corporate_name: 'CodePlay S.A',
                                cnpj: '55477618000139',
                                billing_address: 'Passagem Morumbi',
                                billing_email: 'faturamento@codeplay.com.br',
                                token: SecureRandom.base58(20))

      product = Product.create!(name: 'Ruby', price: 450, bank_slip_discount: 4,
                                credit_card_discount: 5, pix_discount: 6,
                                token: SecureRandom.base58(20), company: company)

      payment_method = PaymentMethod.create!(name: 'Cartão de Crédito MestreCard',
                                             tax: 12, max_tax: 20,
                                             status: true, form_of_payment: 2)

      credit_card = CreditCard.create!(credit_code: 'meRT648dV545t24591ZU',
                                       payment_method: payment_method, company: company)

      final_client = FinalClient.create!(name: 'João Silva', cpf: '12345678910',
                                         token: SecureRandom.base58(20))

      post '/api/v1/charges', params: {

        charge: {

          company_token: company.token,
          product_token: product.token,
          payment_method_id: payment_method.id,
          final_client_token: final_client.token,
          credit_card_id: credit_card.id,
          card_number: '1234567887654321',
          card_holder_name: 'João Silva',
          cvv: '123'
        }
      }

      parsed_body = JSON.parse(response.body)
      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['original_value']).to eq('450.0')
      expect(parsed_body['discounted_amount']).to eq('427.5')
      expect(parsed_body['token']).to eq(Charge.last.token.to_s)
      expect(parsed_body['status']).to eq(Charge.last.status.to_s)
      expect(parsed_body['card_number']).to eq('1234567887654321')
      expect(parsed_body['card_holder_name']).to eq('João Silva')
      expect(parsed_body['cvv']).to eq('123')
    end

    it 'must create a pix payment method' do

      company = Company.create!(corporate_name: 'CodePlay S.A',
                                cnpj: '55477618000139',
                                billing_address: 'Passagem Morumbi',
                                billing_email: 'faturamento@codeplay.com.br',
                                token: SecureRandom.base58(20))

      product = Product.create!(name: 'Ruby', price: 450, bank_slip_discount: 4,
                                credit_card_discount: 5, pix_discount: 6,
                                token: SecureRandom.base58(20), company: company)

      payment_method = PaymentMethod.create!(name: 'Pix Banco Roxinho',
                                             tax: 8, max_tax: 15,
                                             status: true, form_of_payment: 3)

      pix = Pix.create!(bank_number: '001', pix_key: 'a46Hu7dV545t24591ZU1',
                        payment_method: payment_method, company: company)

      final_client = FinalClient.create!(name: 'João Silva', cpf: '12345678910',
                                         token: SecureRandom.base58(20))

      post '/api/v1/charges', params: {

        charge: {

          company_token: company.token,
          product_token: product.token,
          payment_method_id: payment_method.id,
          final_client_token: final_client.token,
          pix_id: pix.id

        }
      }

      parsed_body = JSON.parse(response.body)
      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['original_value']).to eq('450.0')
      expect(parsed_body['discounted_amount']).to eq('423.0')
      expect(parsed_body['token']).to eq(Charge.last.token.to_s)
      expect(parsed_body['status']).to eq(Charge.last.status.to_s)
    end

    it 'should not create a charge with invalid params' do

      post '/api/v1/charges', params: { charge: { number: 100 } }

      parsed_body = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['message']).to include('Parâmetro inválido')

    end
  end
end
