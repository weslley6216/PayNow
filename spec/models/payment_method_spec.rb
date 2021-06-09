require 'rails_helper'

describe PaymentMethod do
  it { should validate_numericality_of(:tax).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:max_tax).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:tax) }
  it { should validate_presence_of(:max_tax) }
end

describe 'Unique name' do
  subject { PaymentMethod.create!(name: 'Pix Roxinho', tax: 1.5, max_tax: 7.3, status: true, form_of_payment: 3) }
  it { should validate_uniqueness_of(:name).case_insensitive }
end
