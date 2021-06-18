require 'rails_helper'

describe 'POST /api/V1/final_clients' do
  it 'should create a final client' do

    company = Company.create!(corporate_name: 'CodePlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'Passagem Morumbi',
                              billing_email: 'faturamento@codeplay.com.br')

    post '/api/v1/final_clients', params: {
      final_client: { name: 'João Silva', cpf: '12345678900' },
      company_token: company.token
    }

    parsed_body = JSON.parse(response.body)
    expect(response).to have_http_status(201)
    expect(response.content_type).to include('application/json')
    expect(parsed_body['name']).to eq('João Silva')
    expect(parsed_body['cpf']).to eq('12345678900')
    expect(FinalClient.last.companies).to include(company)
  end

  it 'should not create a client final with invalid params' do
    Company.create!(corporate_name: 'CodePlay S.A',
                    cnpj: '55477618000139',
                    billing_address: 'Passagem Morumbi',
                    billing_email: 'faturamento@codeplay.com.br')

    post '/api/v1/final_clients', params: {
      final_client: { number: 123, code: 10 }
    }

    parsed_body = JSON.parse(response.body)
    expect(response).to have_http_status(422)
    expect(response.content_type).to include('application/json')
    expect(parsed_body['name']).to eq(['não pode ficar em branco'])
    expect(parsed_body['cpf']).to include('não pode ficar em branco')
  end

  it 'and cannot associate the same end customer repeatedly' do
    company = Company.create!(corporate_name: 'CodePlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'Passagem Morumbi',
                              billing_email: 'faturamento@codeplay.com.br',
                              token: SecureRandom.base58(20))

    final_client = FinalClient.create!(name: 'João Silva', cpf: '12345678910')
    FinalClientCompany.create!(company: company, final_client: final_client)


    post '/api/v1/final_clients', params: {
      final_client: { name: 'João Silva', cpf: '12345678910' },
      company_token: company.token
    }
    expect(response.content_type).to include('application/json')
    expect(response).to have_http_status(422)
    expect(response.body).to include('já está em uso')
   

  end

  it 'and attributes cannot blank' do
    company = Company.create!(corporate_name: 'CodePlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'Passagem Morumbi',
                              billing_email: 'faturamento@codeplay.com.br')

    post '/api/v1/final_clients', params: {
      final_client: { name: '', cpf: '' },
      company_token: company.token
    }

    parsed_body = JSON.parse(response.body)
    expect(response).to have_http_status(422)
    expect(response.content_type).to include('application/json')
    expect(parsed_body['name']).to eq(['não pode ficar em branco'])
    expect(parsed_body['cpf']).to include('não pode ficar em branco')
  end
end
