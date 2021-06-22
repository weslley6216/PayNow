require 'rails_helper'

describe Company do
  it { should validate_presence_of(:corporate_name) }
  it { should validate_presence_of(:cnpj) }
  it { should validate_presence_of(:billing_address) }
  it { should validate_presence_of(:billing_email) }
  it { should validate_numericality_of(:cnpj).is_greater_than_or_equal_to(0) }
  it { should validate_length_of(:cnpj).is_equal_to(14) }
end