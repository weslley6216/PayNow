require 'rails_helper'

describe FinalClient do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:cpf) }
  it { should validate_numericality_of(:cpf).is_greater_than_or_equal_to(0) }
  it { should validate_length_of(:cpf).is_equal_to(11) }
end

describe 'Unique cpf' do
  subject { FinalClient.create!(name: 'José Souza', cpf: '98765432100') }
  it { should validate_uniqueness_of(:cpf).case_insensitive }
end
