require 'rails_helper'

describe Charge do
  it { should validate_presence_of(:original_value) }
  it { should validate_presence_of(:discounted_amount) }
  it { should validate_presence_of(:status) }
end
