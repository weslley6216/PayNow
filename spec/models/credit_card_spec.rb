require 'rails_helper'

describe CreditCard do
  it { should validate_presence_of(:credit_code) }
  it { should validate_length_of(:credit_code).is_equal_to(20) }
end
