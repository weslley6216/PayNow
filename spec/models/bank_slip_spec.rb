require 'rails_helper'

describe BankSlip do
  it { should validate_presence_of(:bank_number) }
  it { should validate_presence_of(:agency_number) }
  it { should validate_presence_of(:account_number) }
end

