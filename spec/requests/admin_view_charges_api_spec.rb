require 'rails_helper'

describe 'admin view all charges of a company' do
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
                    final_client: final_client, product: product, bank_slip: bank_slip,
                    address: 'Colméias, 83', district: 'Alvarenga', zip_code: '09856-280',
                    city: 'São Bernardo do Campo - SP')


    login_admin
    get '/api/v1/charges/', params:
      {
        company_token: company.token
      }

    parsed_body = JSON.parse(response.body)
    expect(response).to have_http_status(200)
    expect(response.content_type).to include('application/json')
    expect(parsed_body[0]['original_value']).to eq('450.0')
    expect(parsed_body[0]['discounted_amount']).to eq('432.0')
    expect(parsed_body[0]['token']).to eq(Charge.last.token.to_s)
    expect(parsed_body[0]['status']).to eq(Charge.last.status.to_s)
    expect(parsed_body[0]['address']).to eq('Colméias, 83')
    expect(parsed_body[0]['district']).to eq('Alvarenga')
    expect(parsed_body[0]['zip_code']).to eq('09856-280')
    expect(parsed_body[0]['city']).to eq('São Bernardo do Campo - SP')
  end

  it 'should return a 404 status if the parameters are incorrect' do

    get '/api/v1/charges/', params: { course: '10' }

    expect(response).to have_http_status(404)
    expect(response.body).to include('parãmetros inválidos')
  end

  it 'should return a 404 status if the company token is empty' do

    get '/api/v1/charges/', params: {}

    expect(response).to have_http_status(404)
    expect(response.body).to include('parãmetros inválidos')
  end
end
