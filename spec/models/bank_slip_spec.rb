require 'rails_helper'

describe BankSlip do
  it { should validate_presence_of(:bank_number) }
  it { should validate_presence_of(:agency_number) }
  it { should validate_presence_of(:account_number) }
  it { should validate_numericality_of(:bank_number).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:agency_number).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:account_number).is_greater_than_or_equal_to(0) }
  it { should validate_length_of(:bank_number).is_equal_to(3) }
  it { should validate_length_of(:agency_number).is_equal_to(4) }
  it { should validate_length_of(:account_number).is_at_least(5).is_at_most(8) }
end

