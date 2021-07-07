require 'rails_helper'

describe Company do
  it { should validate_presence_of(:corporate_name) }
  it { should validate_presence_of(:cnpj) }
  it { should validate_presence_of(:billing_address) }
  it { should validate_presence_of(:billing_email) }
  it { should validate_numericality_of(:cnpj).is_greater_than_or_equal_to(0) }
  it { should validate_length_of(:cnpj).is_equal_to(14) }
end

context 'token' do
  it 'generate a random token when creating' do
    company = Company.create!(corporate_name: 'CoPlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'PassagemMorumbi',
                              billing_email: 'faturamento@codplay.com.br')

    expect(company.token).to be_present
  end

  it 'generate another token if repeats' do
    company = Company.create!(corporate_name: 'CoPlay S.A',
                              cnpj: '55477618000139',
                              billing_address: 'PassagemMorumbi',
                              billing_email: 'faturamento@codplay.com.br')
    another_company = Company.new(corporate_name: 'Treinadev S.A',
                                  cnpj: '55477618000176',
                                  billing_address: 'Passagem Pacaembu',
                                  billing_email: 'faturamento@treinadev.com.br')
    allow(SecureRandom).to receive(:base58).and_return(company.token, SecureRandom.base58(20))

    another_company.save
    expect(company.token).to_not eq(another_company.token)
  end
end

